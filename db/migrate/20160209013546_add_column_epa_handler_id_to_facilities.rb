class AddColumnEpaHandlerIdToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :epa_handler_id, :string
  end
end
