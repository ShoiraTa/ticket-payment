class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.references :ticket, null: false, foreign_key: true
      t.integer :tickets_count
      t.integer :user_id

      t.timestamps
    end
  end
end
