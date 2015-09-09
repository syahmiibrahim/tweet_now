class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :tweethandle
      t.string :token
      t.string :token_secret
      t.timestamps null:false
    end
  end
end
