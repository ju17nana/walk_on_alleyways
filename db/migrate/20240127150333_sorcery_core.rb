class SorceryCore < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :users, id: :uuid do |t|
      t.string :email,            null: false, index: { unique: true }
      t.string :crypted_password, null: false
      t.string :salt,             null: false
      t.string :nickname

      t.timestamps                null: false
    end
  end
end
