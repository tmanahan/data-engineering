require 'test_helper'

class SaleTest < ActiveSupport::TestCase
  # Some simple tests for sales
  test "Should save valid sale" do
    a_sale = Sale.new(:purchaser_name => "New Purchaser",
      :purchase_count => 2, :item_id => items(:one).id)
    assert a_sale.save
  end

  test "Should not save with long purchaser_name" do
    a_sale = Sale.new(:purchaser_name => "New Purchaser, with a name
        that is too long, longer than 100 characters
        1234567890123456789012345678901234567890123456789012345678901234567890",
      :purchase_count => 2, :item_id => items(:one).id)
    assert !a_sale.save
  end

end
