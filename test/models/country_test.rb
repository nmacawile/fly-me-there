require 'test_helper'

class CountryTest < ActiveSupport::TestCase
  def setup
    @country = Country.new(name: "Example Country",
                           iso: "EX")
  end
  
  test "should be valid" do
    assert @country.valid?
  end
  
  test "name should not be blank" do
    @country.name = ""
    assert_not @country.valid?
  end
  
  test "iso should not be blank and should be unique" do
    @country.iso = ""
    assert_not @country.valid?
    @country.iso = "RF"
    assert_not @country.valid?
  end
end
