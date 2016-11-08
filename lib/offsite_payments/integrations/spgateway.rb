require File.dirname(__FILE__) + "/spgateway/helper.rb"

module OffsitePayments
  module Integrations
    module Spgateway
      mattr_accessor :test_service_url
      self.test_service_url = "https://ccore.spgateway.com/MPG/mpg_gateway"

      mattr_accessor :production_service_url
      self.production_service_url = "https://core.spgateway.com/MPG/mpg_gateway"

      mattr_accessor :test_confirmation_url
      self.test_confirmation_url = ":https://ccore.spgateway.com/API/QueryTradeInfo"

      mattr_accessor :production_confirmation_url
      self.production_confirmation_url = "https://core.spgateway.com/API/QueryTradeInfo"

      def self.service_url
        self.production_service_url
      end

      def self.confirmation_url
        self.production_confirmation_url
      end

      def self.setup
        yield(self)
      end

      def self.notification(post, options = {})
        Notification.new(post)
      end
    end
  end
end
