require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  # Some simple tests for merchants
  test "should save valid merchant" do
    a_merchant = Merchant.new(:name => "New Merchant", :address => "New Address")
    assert a_merchant.save
  end

  test "should not save with long name" do
    a_merchant = Merchant.new(:name => "New Merchant, with a name that is
      too long, longer than 100 characters
      1234567890123456789012345678901234567890123456789012345678901234567890",
      :address => "New Address")
    assert !a_merchant.save
  end

  test "should not save with long address" do
    a_merchant = Merchant.new(:name => "New Merchant",
      :address => "New merchant with an
        Address that is too long, longer than 100 characters
        1234567890123456789012345678901234567890123456789012345678901234567890")
    assert !a_merchant.save
  end

  test "should not save with duplicate name" do
    merchant_1 = Merchant.new(:name => "New Merchant",
      :address => "Merchant 1 address")
    merchant_2 = Merchant.new(:name => "New Merchant",
      :address => "Merchant 2 address")
    assert merchant_1.save
    assert !merchant_2.save
  end

end
