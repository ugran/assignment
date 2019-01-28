require_relative 'adapters/paypal.rb'
require_relative 'adapters/stripe.rb'

class Payment
    class << self
      def for(type)
        case type
        when :paypal
          Paypal.new
        when :stripe
          Stripe.new
        end
      end
    end
  end