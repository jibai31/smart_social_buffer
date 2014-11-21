class CreateBufferedWeeks < ActiveRecord::Migration
  def change
    create_table :buffered_weeks do |t|
      t.references :planning, index: true
      t.date :first_day

      t.timestamps
    end
  end
end
