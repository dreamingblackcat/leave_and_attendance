class CreateLeavePeriods < ActiveRecord::Migration
  def change
    create_table :leave_periods do |t|
      t.string :name
      t.string :start_time
      t.string :end_time

      t.timestamps
    end
  end
end
