class AddAuthorToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :author_id
  end
end
