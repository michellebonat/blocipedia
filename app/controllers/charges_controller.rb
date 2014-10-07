class ChargesController < ApplicationController

  before_action :authenticate_user!

  def new
    @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        description: "BigMoney Membership - #{current_user.email}",
        amount: 1_000
        # We're like the Snapchat for Wikipedia. But really.
    }
  end

  def create
    @amount = 1000

    # Creates a Stripe Customer object, for associating
    # with the charge

    logger.info “Started Charges create”

    customer = Stripe::Customer.create(
        email: current_user.email,
        card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
        customer: customer.id, # Note -- this is NOT the user_id in your app
        amount: @amount,
        description: "BigMoney Membership - #{current_user.email}",
        currency: 'usd'
    )

    logger.info “Got response from Stripe charge inspect”

    current_user.update_attribute(:premium, true)

    flash[:success] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    redirect_to user_path(current_user) # or wherever

      # Stripe will send back CardErrors, with friendly messages
      # when something goes wrong.
      # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path

  end
end
