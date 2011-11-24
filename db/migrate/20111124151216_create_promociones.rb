class CreatePromociones < ActiveRecord::Migration
  def change
    create_table :promociones do |t|

      t.timestamps
    end
  end
end
