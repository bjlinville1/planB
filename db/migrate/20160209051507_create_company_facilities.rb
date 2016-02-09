class CreateCompanyFacilities < ActiveRecord::Migration
  def change
    create_table :company_facilities do |t|
      t.integer :facility_id
      t.integer :company_id
      t.timestamps null: false
    end
  end
end
