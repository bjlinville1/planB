module FacilitiesHelper
  def build_facility_address_string(facility_object)
    "#{facility_object.location} "+"\n"+"#{facility_object.city}, "+"#{facility_object.state} "+"#{facility_object.zip}"
  end

  def find_appropriate_values_to_display(user) 
    if user.account_status == "SuperUser"
      @keys_array = @free_values+@registered_users+@admins+@super_users
    elsif user.account_status == "admin"
      @keys_array = @free_values+@registered_users+@admins
    elsif user.account_status == "registered_user"
      @keys_array = @free_values+@registered_users
    else
      @keys_array = @free_values
    end
  end

end
