class DummyToBeDeleted < ActiveRecord::Migration

  def change

    rename_table :dsc_enrollments, :enrollments

    add_reference :enrollments, :grid_reference, index: true

    create_table :exemptions do |t|
      t.string  :code
      t.string  :summary
      t.text    :description
      t.string  :url
      t.integer :category

      t.date		:valid_from
      t.date		:valid_to

      t.timestamps null: false
    end

    create_table :enrollments_exemptions, force: :cascade do |t|
      t.integer  "enrollment_id",        null: false
      t.integer  "exemption_id",         null: false
      t.integer  "status",               default: 0
      t.datetime "expires_at"
      t.datetime "valid_from"
    end


    add_reference :enrollments, :organisation

  end

end
