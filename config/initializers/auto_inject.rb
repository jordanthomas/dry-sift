module PaymentsSandbox
  
  class Container
    extend Dry::Container::Mixin

    namespace(:operations) do
      register(:track_transaction) { Fraud::Operations::TrackTransaction.new }
    end

    namespace(:clients) do
      register(:fraud) { Fraud::Adapters::Sift.new(account_id: '', api_key: '') }
    end
  end

  Import = Dry::AutoInject(Container)
end
