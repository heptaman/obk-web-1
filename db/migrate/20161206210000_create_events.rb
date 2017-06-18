class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string   :title          ,limit: 80   ,null: false
      t.text     :description
      t.datetime :start                       ,null: false
      t.datetime :finish                      ,null: false
      t.integer  :min_volunteers
      t.integer  :max_volunteers

      t.timestamps
    end
  end
end
