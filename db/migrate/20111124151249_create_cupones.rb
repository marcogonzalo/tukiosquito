class CreateCupones < ActiveRecord::Migration
  def change
    create_table :cupones do |t|

      t.timestamps
    end
  end
end
