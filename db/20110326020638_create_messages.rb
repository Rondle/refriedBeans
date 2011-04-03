class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :user_id_from
      t.integer :user_id_to
      t.text :text

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
