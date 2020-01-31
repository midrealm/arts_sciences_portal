class CreateUserPeerages < ActiveRecord::Migration[6.0]
  def change
    create_table :user_peerages do |t|
      t.references :user, null: false, foreign_key: true
      t.references :peerage, null: false, foreign_key: true

      t.timestamps
    end
  end
end
