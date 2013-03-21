class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :avatar
      t.string :displayname
      t.text :bio
      t.timestamps
    end
  end
end
