class AddAuthorToQuestion < ActiveRecord::Migration
  def change
    add_reference :questions, :author, index: true, foreign_key: true
  end
end
