require "dry/monads"
require "dry/monads/do"

module Fraud
  module Operations
    class TrackTransaction
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      def call(payload:)
        score = yield track_and_score(payload)

        Success(score)
      end

      def track_and_score(payload)
        event_client = Fraud::Event.new
        response = event_client.transaction(payload: payload, with_score: true)

        if response.ok?
          Success(response.body["score_response"]["scores"]["payment_abuse"]["score"])
        else
          Failure("Error!")
        end
      end
    end
  end
end