class AddColumnFacilityAliasToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :facility_alias, :string
  end
end
