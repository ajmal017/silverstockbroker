class News < ActiveRecord::Migration[5.1]
  def change
    drop_table :news do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
