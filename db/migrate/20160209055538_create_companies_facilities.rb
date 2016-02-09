class CreateCompaniesFacilities < ActiveRecord::Migration
  def change
    create_table :companies_facilities do |t|
      t.integer :facility_id
      t.integer :company_id

      t.timestamps null: false
    end
  end
end
