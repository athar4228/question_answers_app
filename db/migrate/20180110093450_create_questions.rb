class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :title, limit:  150, null: false, index: true
      t.text :body, null: false
      t.belongs_to :user, null: false
      t.timestamps
    end
  end
end
