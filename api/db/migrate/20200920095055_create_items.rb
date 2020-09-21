class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.text :title, null: false
      t.text :image_url, null: false
      t.timestamps
    end
  end
end
