class CreateApiRequests < ActiveRecord::Migration
  def change
    create_table :api_requests do |t|
      t.string :method, null: false
      t.string :path,   null: false
      t.jsonb :headers, null: false, default: '{}'
      t.jsonb :payload, defauult: '{}'
      t.timestamps      null: false
    end

    add_index :api_requests, :payload, using: :gin
  end
end
