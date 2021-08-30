module Fraud
  module Adapters
    class Sift < Fraud::Adapters::Base
      def initialize(account_id:, api_key:)
        @client = ::Sift::Client.new(account_id: account_id, api_key: api_key)
      end

      def transaction(payload:, with_score:)
        @client.track("$transaction", transform_payload(payload), return_score: with_score, abuse_types: ["payment_abuse"])
      end

      private

      def siftify_symbol(str)
        "$#{str.downcase}"
      end
      
      def transform_payload(payload)
        {
          "$user_id"            => payload[:user_id],
          "$user_email"         => payload[:user_email],
          "$seller_user_id"     => payload[:dispensary_id],
          "$order_id"           => payload[:order_id],
          "$amount"             => payload[:amount],
          "$currency_code"      => payload[:currency_code],
          "$transaction_type"   => siftify_symbol(payload[:transaction_type]),
          "$transaction_status" => siftify_symbol(payload[:transaction_status]),
          "$transaction_id"     => payload[:transaction_id],
          "$payment_method"     => {
            "$payment_type"     => siftify_symbol(payload[:payment_method][:payment_type]),
            "$routing_number"   => siftify_symbol(payload[:payment_method][:routing_number]),
          }
        }
      end
    end
  end
end