class CreatePlannings < ActiveRecord::Migration
  def change
    create_table :plannings do |t|
      t.references :account, index: true

      t.timestamps
    end
  end
end
