class Facility < ActiveRecord::Base

  geocoded_by :location
  #may want to move this to an external process, as Ryan B demonstrates in railscasts
  after_validation :geocode, :if => :location_changed?

  has_and_belongs_to_many :companies

  def self.search_facilities location=''
    if location.present?
      # :order => :distance
      Facility.near(location, 2000, unit: :mi)
          # @locations = Location.near(params[:search], 50, :order => :distance)

      # to do: sort by distance
      # to do: raise exception if no facilities are found, and display index page without any facilities found
    else
      Facility.all
    end
  end
end
