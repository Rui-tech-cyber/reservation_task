class AddConfirmedAtToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :confirmed_at, :datetime unless column_exists?(:reservations, :confirmed_at)
  end
end
