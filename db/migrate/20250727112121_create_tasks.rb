class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :status, default: "pending"
      t.datetime :due_date

      t.timestamps
    end
  end
end
