require "active_merchant_spgateway/version"
require "action_view"
require "active_merchant"
require "offsite_payments"

module ActiveMerchantSpgateway
  # Your code goes here...
end

ActionView::Base.send(:include, OffsitePayments::ActionViewHelper)
