# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120112163236) do

  create_table "administradores", :force => true do |t|
    t.string   "nombre",             :limit => 50
    t.string   "apellido",           :limit => 50
    t.string   "correo_electronico", :limit => 100, :null => false
    t.string   "usuario",            :limit => 50,  :null => false
    t.string   "clave",              :limit => 50,  :null => false
    t.string   "tipo",               :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categorias", :force => true do |t|
    t.string "nombre",      :limit => 100, :null => false
    t.string "descripcion"
  end

  create_table "clientes", :force => true do |t|
    t.string   "nombre",             :limit => 100,                  :null => false
    t.string   "apellido",           :limit => 100,                  :null => false
    t.string   "sexo",               :limit => 1,   :default => "M", :null => false
    t.date     "fecha_nacimiento"
    t.string   "correo_electronico", :limit => 100,                  :null => false
    t.string   "usuario",            :limit => 50,                   :null => false
    t.string   "clave",              :limit => 50,                   :null => false
    t.string   "telefono",           :limit => 25
    t.string   "direccion",                                          :null => false
    t.string   "ciudad",             :limit => 50,                   :null => false
    t.string   "estado",             :limit => 20,                   :null => false
    t.string   "pais",               :limit => 50,                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cupones", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facturas_distribuidores", :force => true do |t|
    t.integer  "orden_id",                     :null => false
    t.string   "distribuidor",  :limit => 100, :null => false
    t.string   "numero_orden",  :limit => 20,  :null => false
    t.float    "total",                        :null => false
    t.date     "fecha_entrega",                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ordenes", :force => true do |t|
    t.integer  "usuario_id",                         :null => false
    t.integer  "tarjeta_id",                         :null => false
    t.string   "direccion_entrega",                  :null => false
    t.float    "total",             :default => 0.0, :null => false
    t.date     "fecha_entrega"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "productos", :force => true do |t|
    t.string   "nombre",          :limit => 100,                    :null => false
    t.string   "descripcion",                                       :null => false
    t.integer  "categoria_id",    :limit => 3,                      :null => false
    t.integer  "subcategoria_id", :limit => 3
    t.float    "precio",                                            :null => false
    t.integer  "cantidad",        :limit => 5,                      :null => false
    t.float    "peso",            :limit => 2,                      :null => false
    t.integer  "alto",            :limit => 5
    t.integer  "ancho",           :limit => 5
    t.integer  "largo",           :limit => 5
    t.boolean  "resaltar",                       :default => false
    t.date     "fecha_fin_venta",                                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "promociones", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subcategorias", :force => true do |t|
    t.string  "nombre",       :limit => 100, :null => false
    t.string  "descripcion"
    t.integer "categoria_id", :limit => 3,   :null => false
  end

  create_table "tdc", :force => true do |t|
    t.integer  "numero",          :limit => 20,                     :null => false
    t.string   "tipo",            :limit => 20, :default => "Visa", :null => false
    t.integer  "codigo",          :limit => 3,  :default => 0,      :null => false
    t.integer  "mes_vencimiento", :limit => 2,  :default => 12,     :null => false
    t.integer  "ano_vencimiento", :limit => 2,  :default => 12,     :null => false
    t.string   "direccion",                                         :null => false
    t.string   "tarjetahabiente",                                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ventas", :force => true do |t|
    t.integer  "producto_id",                :null => false
    t.integer  "orden_id",                   :null => false
    t.integer  "cantidad",    :default => 1, :null => false
    t.float    "costo",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
