module Fraud
    module Adapters
      class Base
        def transaction(payload:)
          throw "Transaction event must be implemented by client!"
        end
      end
    end
  end