class CreateAdministradores < ActiveRecord::Migration
  def change
    create_table :administradores do |t|

      t.timestamps
    end
  end
end
