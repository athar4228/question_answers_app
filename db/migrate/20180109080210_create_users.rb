class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :uid, null: false, limit: 150, index: true
      t.string :first_name, limit: 150, index: true
      t.string :last_name, limit: 150
      t.string :email, null: false, limit: 100, index: true, unique: true
      t.string :provider, limit: 150
      t.timestamps
    end
  end
end
