module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  class Sklonjator
    def self.sklonenie (number, krokodil, krokodila, krokodilov)
      if (number == nil || !number.is_a?(Numeric))
        number = 0
      end

      ost = number%10
      ost_100 = number%100

      if (ost_100 == 11 || ost_100 == 12 || ost_100 == 13 || ost_100 == 14)
        return krokodilov
      end

      if (ost == 1)
        return krokodil
      end

      if (ost >= 2 && ost <=4)
        return krokodila
      end

      if (ost > 4 || ost == 0)
        return krokodilov
      end
    end
  end


  def questions_count(questions_array)
    sklonenie = Sklonjator.sklonenie(questions_array.length.to_i,'вопрос', 'вопроса', 'вопросов')
    return questions_array.length.to_s+" "+sklonenie
  end


end
