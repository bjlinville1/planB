class CompanyFacility < ActiveRecord::Base
  belongs_to :company
  belongs_to :facility
end
