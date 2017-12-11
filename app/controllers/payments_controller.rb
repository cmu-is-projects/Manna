class PaymentsController < ApplicationController

    before_action :set_payment, only: [:show, :edit, :update, :destroy]

  # GET /payments
  # GET /payments.json
  def index
    if logged_in?
      @payments = Payment.all
    else
      redirect_to home_path
    end
  end

  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      redirect_to payments_path, notice: "Successfully created payment."
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    if @payment.update(payment_params)
      redirect_to payments_path, notice: "Successfully updated payment."
    else
      render action: 'edit'
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    redirect_to payments_path, notice: "Successfully removed payment."
  end

  private
  def set_payment
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:payment_type, :payable_to, :amount, :case_id, :description)
  end

end
