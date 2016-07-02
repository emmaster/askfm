require 'openssl'

class User < ActiveRecord::Base

  #параметры работы модуля шифрования
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: {case_sensitive: false}
  validates :email, format: {with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i}
  validates :username, format: {with: /\A[a-zA-Z0-9_]*\z/}
  validates :username, length: {maximum: 40}

  attr_accessor :password

  validates_presence_of :password, on: create
  validates_confirmation_of :password #эта строка говорит о том, что в этом объекте должно быть второе поле с именем password_confirmation

  before_save :encrypt_password, :downcased
  before_update :downcased

  def downcased
    self.username = self.username.downcase if self.username.present?
  end


  def encrypt_password
    #если пароль у объекта для которого мы вычисляем зашифрованный пароль присутсвует, то:
    if self.password.present?
      #создаем т.н соль — рандомную строку, усложняющую задачу хакерам
      self.password_salt= User.hash_to_string(OpenSSL::Random.random_bytes(16))

      #создаем hash пароля — длинная уникальная строка, из которой невозможно
      #восстановить исходный пароль
      self.password_hash = User.hash_to_string(
          OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )

    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email) #находим пользователя по email
    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length,DIGEST))
      user
    else
      nil
    end
  end
end
