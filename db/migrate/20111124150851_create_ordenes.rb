class CreateOrdenes < ActiveRecord::Migration
  def change
    create_table :ordenes do |t|

      t.timestamps
    end
  end
end
