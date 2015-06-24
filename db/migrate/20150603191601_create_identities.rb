class CreateIdentities < ActiveRecord::Migration
  def change

    drop_table :identities


    create_table :identities do |t|
      t.references :user, index: true
      t.string :provider
      t.string :accesstoken
      t.string :refreshtoken
      t.string :uid
      t.string :name
      t.string :email
      t.string :nickname
      t.string :image
      t.string :phone
      t.string :urls

      t.timestamps
    end
  end
end
