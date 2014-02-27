class SaleRecordsController < ApplicationController
  # 2/25/2014 Ted Manahan
  # This controller manages the upload of data files for the Living Social
  #   data import test.

  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def upload_action

    # Some counts of interest
    @total_amount_gross_revenue = 0
    @line_count = 0
    @new_merchant_count = 0
    @new_item_count = 0
    @new_sale_count = 0
    @error_array = Array.new

    # Read each line of the input file
    while (line = params[:upload]['datafile'].gets)
      @line_count += 1
      line.chomp! # Remove trailing control characters

      # each line has tab separated fields
      delimiter = "\t"
      fields = line.split(delimiter)

      # Quick check to make sure each line has six columns
      if fields.size != 6
        @error_array << "line #{@line_count} discarded, not exactly six fields."
      else

        # Capture the required data fields
        purchaser_name = fields[0]
        item_description = fields[1]
        item_price = fields[2]
        purchase_count = fields[3]
        merchant_address = fields[4]
        merchant_name = fields[5]

        # Validate that the header line has the necessary column names
        if @line_count == 1
          if purchaser_name != 'purchaser name' ||
              item_description != 'item description' ||
              item_price != 'item price' ||
              purchase_count != 'purchase count' ||
              merchant_address != 'merchant address' ||
              merchant_name != 'merchant name'
            @error_array << "ERROR: header line does not have required fields. " +
              "Aborting upload."
            break
          end
        else # @line_count > 1
          item_price = item_price.to_f
          purchase_count = purchase_count.to_i

          # Project requirement; sum gross revenue from each line
          @total_amount_gross_revenue += item_price * purchase_count

          #============ merchant =======================
          # Find existing merchant
          merchant = Merchant.find_by_name(merchant_name)
          if merchant.nil?
            # Create a new merchant
            merchant = Merchant.new(:name => merchant_name, :address => merchant_address)
            merchant.save
            @new_merchant_count += 1
          end

          #============ item =======================
          # Find existing item
          item = Item.find_by_description_and_merchant_id(
            item_description, merchant.id)
          if item.nil?
            # Create a new item
            item = Item.new(:description => item_description, :price => item_price,
              :merchant_id => merchant.id)
            item.save
            @new_item_count += 1
          end

          #============ sale =======================
          # Always create a new sale
          sale = Sale.new(:purchaser_name => purchaser_name,
            :purchase_count => purchase_count, :item_id => item.id)
          sale.save
          @new_sale_count += 1 # always equals @line_count - 1

        end # @line_count > 1
      end # if fields.size != 6
    end # done with the input file

    respond_to do |format|
      format.html # index.html.erb
    end
  end # upload_action

end
