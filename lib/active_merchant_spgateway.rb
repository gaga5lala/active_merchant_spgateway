require "active_merchant_spgateway/version"
require "action_view"

module ActiveMerchantSpgateway
  # Your code goes here...
end

ActionView::Base.send(:include, OffsitePayments::ActionViewHelper)
