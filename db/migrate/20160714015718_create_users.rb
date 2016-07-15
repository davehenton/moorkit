class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.uuid :uuid,                 null: false, default: 'uuid_generate_v4()'
      t.jsonb :details,             null: false, default: '{}'
      t.string :email,              null: false

      t.timestamps                  null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :uuid, unique: true
    add_index :users, :details, using: :gin
  end
end
