class CreateTdc < ActiveRecord::Migration
  def change
    create_table :tdc do |t|

      t.timestamps
    end
  end
end
