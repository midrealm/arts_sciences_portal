class CreatePeerages < ActiveRecord::Migration[6.0]
  def change
    create_table :peerages do |t|
      t.string :description

      t.timestamps
    end
  end
end
