class CompaniesFacility < ActiveRecord::Base
  belongs_to :company
  belongs_to :facility
end
