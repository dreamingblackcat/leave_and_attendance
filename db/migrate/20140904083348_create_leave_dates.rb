class CreateLeaveDates < ActiveRecord::Migration
  def change
    create_table :leave_dates do |t|
      t.date :date
      t.belongs_to :leave_period, index: true
      t.boolean :granted
      t.belongs_to :leave_application, index: true

      t.timestamps
    end
  end
end
