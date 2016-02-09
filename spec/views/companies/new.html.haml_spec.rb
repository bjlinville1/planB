require 'rails_helper'

RSpec.describe "companies/new", :type => :view do
  before(:each) do
    assign(:company, Company.new(
      :company_name => "MyString"
    ))
  end

  it "renders new company form" do
    render

    assert_select "form[action=?][method=?]", companies_path, "post" do

      assert_select "input#company_company_name[name=?]", "company[company_name]"
    end
  end
end
