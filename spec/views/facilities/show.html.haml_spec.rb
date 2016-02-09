require 'rails_helper'

RSpec.describe "facilities/show", :type => :view do
  before(:each) do
    @facility = assign(:facility, Facility.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
