require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # Some simple tests for items
  test "should save valid item" do
    an_item = Item.new(:description => "New Item",
      :price => 2.02, :merchant_id => merchants(:one).id)
    assert an_item.save
  end

  test "should not save with long description" do
    an_item = Item.new(:description => "New Item, with a long description.
      This description is longer than 100 characters
      1234567890123456789012345678901234567890123456789012345678901234567890",
      :price => 2.02, :merchant_id => merchants(:one).id)
    assert !an_item.save
  end

  test "should not save duplicate item" do
    item_1 = Item.new(:description => "New Item",
      :price => 2.02, :merchant_id => merchants(:one).id)
    item_2 = Item.new(:description => "New Item",
      :price => 3.03, :merchant_id => merchants(:one).id)
    assert item_1.save
    assert !item_2.save
  end

end
