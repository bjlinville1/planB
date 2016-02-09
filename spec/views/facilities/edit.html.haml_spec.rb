require 'rails_helper'

RSpec.describe "facilities/edit", :type => :view do
  before(:each) do
    @facility = assign(:facility, Facility.create!())
  end

  it "renders the edit facility form" do
    render

    assert_select "form[action=?][method=?]", facility_path(@facility), "post" do
    end
  end
end
