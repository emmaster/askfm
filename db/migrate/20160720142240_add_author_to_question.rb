class AddAuthorToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :author_id, index: true
  end
end
