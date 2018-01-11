class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.text :body, null: false
      t.belongs_to :user, null: false
      t.belongs_to :question, null: false
      t.timestamps
    end
    add_index :answers, [:user_id, :question_id], unique: true
  end
end
