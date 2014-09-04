class CreateLeaveApplications < ActiveRecord::Migration
  def change
    create_table :leave_applications do |t|
      t.date :application_date
      t.belongs_to :user, index: true
      t.text :reason
      t.boolean :paid_leave

      t.timestamps
    end
  end
end
