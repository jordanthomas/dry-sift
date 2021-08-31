class OrdersController < ApiController

  include PaymentsSandbox::Import[track_transaction: 'operations.track_transaction']

  def create
    # Imagine this is inside the payment processing code somewhere...
    score = track_transaction.call(payload: payload)
    render json: { score: score.value! }
  end

  def payload
    {
      user_id: "jordan-test-0002",
      user_email: "jordan.thomas@dutchie.com",
      dispensary_id: "jordan-dispo-0002",
      amount: 420000000,
      currency_code: "USD",
      transaction_type: "SALE",
      transaction_status: "SUCCESS",
      order_id: "ORDER-0002",
      transaction_id: "TRANSACTION-0002",
      payment_method: {
        payment_type: "ELECTRONIC_FUND_TRANSFER",
        routing_number: "123456789"
      }
    }
  end
end
