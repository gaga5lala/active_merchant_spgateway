require "active_merchant_spgateway/version"
require "action_view"
require "active_merchant"
require "offsite_payments"

module ActiveMerchantSpgateway
  autoload :Spgateway, "offsite_payments/integrations/spgateway"
end

ActionView::Base.send(:include, OffsitePayments::ActionViewHelper)
