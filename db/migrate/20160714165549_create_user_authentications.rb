class CreateUserAuthentications < ActiveRecord::Migration
  def change
    create_table :user_authentications do |t|
      t.references :user, index: true, foreign_key: true
      t.string :provider, null:false
      t.string :uid, index: true, null:false
      t.string :token
      t.timestamp :expires_at
      t.jsonb :data

      t.timestamps null: false
    end
  end
end
