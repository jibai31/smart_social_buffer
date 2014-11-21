class CreateBufferedDays < ActiveRecord::Migration
  def change
    create_table :buffered_days do |t|
      t.references :buffered_week, index: true
      t.date :day

      t.timestamps
    end
  end
end
