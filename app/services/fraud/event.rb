module Fraud
  class Event

    include PaymentsSandbox::Import[client: 'clients.fraud']

    def transaction(payload:, with_score: false)
      client.transaction(payload: payload, with_score: with_score)
    end
  end
end