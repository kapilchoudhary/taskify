class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.datetime :start_date

      t.timestamps
    end
  end
end
