class FacilitiesController < ApplicationController
  before_action :set_facility, only: [:show, :edit, :update, :destroy]

  def index
    # todo: REFACTOR this mess
    @facilities = Facility.search_facilities(params[:search])
    @company = Company.find(1)
    
    # find facilities matching waste types selected & store them
    @facilities_filtered_by_waste_types_accepted = []
    if params[:waste_types_accepted].blank?
    else
      @facilities.each do |facility|
        if facility.waste_types_accepted.include? params[:waste_types_accepted] 
          @facilities_filtered_by_waste_types_accepted << facility
        end
      end
    end

    # find facilities matching facility types selected & store them
    @facilities_filtered_by_facility_types = []
    if params[:facility_types].blank?
    else
      @facilities.each do |facility|
        if facility.facility_type.include? params[:facility_types] 
          @facilities_filtered_by_facility_types << facility
        end
      end
    end

    #if only one filter is selected, make sure we don't return nothing
    if @facilities_filtered_by_waste_types_accepted & @facilities_filtered_by_facility_types == []
      @filtered_facilities = (@facilities_filtered_by_waste_types_accepted + @facilities_filtered_by_facility_types).uniq
    else
      #otherwise, find the elements common to the arrays and store them in a new variable
      @filtered_facilities = @facilities_filtered_by_waste_types_accepted & @facilities_filtered_by_facility_types
    end

    @facility_types = ["Landfill","Demolition Landfill","Materials Recovery","Materials Recovery & Transfer","Transfer Station","Rail Transload Facility","Incinerator","Waste-to-Energy Plant","Composting"]
    @waste_types = ["Dry Industrial", "Scrap Metals", "MSW", "Sludge", "Tires (Truck)", "Tires (Auto)", "Wood", "Yard Waste", "C&D", "Cont Soil", "Shingles or Roofing Materials", "Waste Carpet Material", "Asphalt", "Concrete", "or Cement", "White Goods & Bulky Wastes", "Non-Friable Asbestos", "Ash", "Cathode Ray Tube", "TV", "Monitor", "Recyclables", "Other Special/Designated Waste", "Tires (Tractor)", "Alternative Daily Cover", "Friable Asbestos", "Animal Waste", "Land Clearing Debris", "Medical Waste","E&P Wastes", "Industrial & Special Waste", "Liquifix (Solidification Services)", "Municipal Solid Waste", "NORM (Naturally Occurring Radioactive Material)", "Yard Waste", "Municipal Solid Waste", "Rail Spur On-Site", "Yard Waste", "Tires", "NORM (Naturally Occurring Radioactive Material)", "Shredded Tires", "Industrial & Special Waste", "Municipal Solid Waste", "Rail Spur On-Site  Asbestos", "Bioremediation of Soils", "Hazardous Waste Transportation", "Lab Pack Services", "Macroencapsulation", "Metals Stabilization", "Microencapsulation", "PCB Landfill (TSCA)", "PCB Transformer/Electrical Services", "RCRA Landfill", "Stabilization", "Storage and Transfer for Recycling", "Wastewater Treatment", "Construction & Demolition Debris", "Industrial & Special Waste", "Tires", "Bioremediation" ]
    #hack to demo the branded user experience
    if user_signed_in?
      if current_user.account_status == "registered_user"

        @branded_facilities = []
        @filtered_facilities.each do |filtered_facility|
          if filtered_facility[:operator_code] == "WM"
            @branded_facilities << filtered_facility
          end
        end
        @filtered_facilities = @branded_facilities

        @other_branded_facilities = []
        
        @facilities.each do |filtered_facility|
          if filtered_facility[:operator_code] == "WM"
            @other_branded_facilities << filtered_facility
          end
        end
        @facilities = @other_branded_facilities
      end
    end
    
    #another hack to allow the demonstration of branded vendor lists          
      if params[:vendor_list_company] == "None"
        #WEIRD. if I hit the else loop here, all the distances messed up, and it really seems like they just fall out of scope.
      elsif params[:vendor_list_company] 
        @q = []
        @z = []
        Company.where(company_name: params[:vendor_list_company]).first.facilities.each do |hrrrmagerrrsh|
          @q << hrrrmagerrrsh
          @z << hrrrmagerrrsh
        end
        @filtered_facilities = @q
        @facilities = @z
      end

    #if no filters are present, build the map from the facilities returned by the search
    if params[:facility_types].blank? && params[:waste_types_accepted].blank?
      #i currently limit the results to the first six, just for convenience sake. Paginating will come later if we want it. 
      @hash = Gmaps4rails.build_markers(@facilities[0..9]) do |facility, marker|
        marker.lat facility.latitude
        marker.lng facility.longitude
        #oh noes, this is super slow
        marker.infowindow render_to_string(:partial => "/facilities/info_window_partial", :locals => { :object => facility})
        marker.title facility.facility_name
        marker.json({
          sidebar: render_to_string(:partial => "/facilities/sidebar_partial", :locals => { :object => facility})
        })
      end
    else #otherwise, build the map from the filtered results
      @hash = Gmaps4rails.build_markers(@filtered_facilities[0..9]) do |facility, marker|
        marker.lat facility.latitude
        marker.lng facility.longitude
        #oh noes, this is super slow
        marker.infowindow render_to_string(:partial => "/facilities/info_window_partial", :locals => { :object => facility})
        marker.title facility.facility_name
        marker.json({
          sidebar: render_to_string(:partial => "/facilities/sidebar_partial", :locals => { :object => facility})
        })
      end
    end
  end
  
  def home_initial
  end

  def show

    @free_values = [
    "facility_alias",      
    "facility_type", #to do: mysql keeps importing the abbreviation
    "permit",
    "operating_days_and_hours",
    "operator_entity", #to do: drop the "entity" portion of this text
    "operator_phone",
    "operator_fax",
    "waste_types_accepted" #when we import WM, we'll need to either display one or the other
    ]

    @registered_users = [
      "county",
      "access",
      "owner_entity",
      "owner_code",
      "operation"
    ]
    #there's redundancy between these two, I'm just gonna trust you split them intentionally, and we can change the variable name to something less confusing later. 
    @admins = [
      "location",
      "city",
      "state",
      "zip",#to do: make this postal code
      "longitude",
      "latitude",
      "waste_shed",
      "ownership",
      "operator_contact",
      "operator_title",
      "operator_department",
      # to do: alter db column names to be
      # "operator_street_address",
      # "operator_city_state_zip",
      # instead of:
      "operator_address_1",
      "operator_address_2",
      "operator_email"
    ]

    @super_users = [
      "epa_handler_id",
      "operator_code",
      "code",
      "group",
      "map_label",
      "days_per_year",
      "acres",
      "total_of_all_wastes_per_day",
      "volume_description",
      "volume_of_primary_waste",
      "primary_waste_description",
      "dollars_per_ton",
      "tip_fee_description",
      "remaining_capacity_in_tons",
      "start_date",
      "close_date",
      "owner_contact",
      "owner_title",
      "owner_department",
      "owner_address_1",
      "owner_address_2",
      "owner_phone",
      "owner_fax",
      "owner_email"
    ]
  end

  def new
    @facility = Facility.new
  end

  def edit
  end

  def create
    @facility = Facility.new(facility_params)

    respond_to do |format|
      if @facility.save
        format.html { redirect_to @facility, notice: 'Facility was successfully created.' }
        format.json { render :show, status: :created, location: @facility }
      else
        format.html { render :new }
        format.json { render json: @facility.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    # @facility.address = "#{@facility.location} " + "#{@facility.city} " + "#{@facility.state} " + "#{@facility.zip} "
    # @facility.address_will_change! #by passing setter method so the model will work

    respond_to do |format|
      if @facility.update(facility_params)
        format.html { redirect_to @facility, notice: 'Facility was successfully updated.' }
        format.json { render :show, status: :ok, location: @facility }
      else
        format.html { render :edit }
        format.json { render json: @facility.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @facility.destroy
    respond_to do |format|
      format.html { redirect_to facilities_url, notice: 'Facility was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_facility
      @facility = Facility.find(params[:id])
    end

    def facility_params
      params.require(:facility).permit(
        :created_at,
        :updated_at,
        :code,
        :facility_type,
        :group,
        :facility_name,
        :permit,
        :map_label,
        :location,
        :city,
        :county,
        :state,
        :zip,
        :longitude,
        :latitude,
        :access,
        :waste_shed,
        :operating_days_and_hours,
        :days_per_year,
        :acres,
        :total_of_all_wastes_per_day,
        :volume_description,
        :volume_of_primary_waste,
        :primary_waste_description,
        :dollars_per_ton,
        :tip_fee_description,
        :remaining_capacity_in_tons,
        :start_date,
        :close_date,
        :ownership,
        :owner_entity,
        :owner_code,
        :owner_contact,
        :owner_title,
        :owner_department,
        :owner_address_1,
        :owner_address_2,
        :owner_phone,
        :owner_fax,
        :owner_email,
        :operation,
        :operator_entity,
        :operator_code,
        :operator_contact,
        :operator_title,
        :operator_department,
        :operator_address_1,
        :operator_address_2,
        :operator_phone,
        :operator_fax,
        :operator_email,
        :waste_types_accepted
      )
    end

        def car_params
      params.require(:car).permit(
        :make,
        :model,
        :year,
        :base_cost,
        feature_ids: []
      )
    end
end
