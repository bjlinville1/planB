require 'rails_helper'

RSpec.describe "facilities/index", :type => :view do
  before(:each) do
    assign(:facilities, [
      Facility.create!(),
      Facility.create!()
    ])
  end

  it "renders a list of facilities" do
    render
  end
end
