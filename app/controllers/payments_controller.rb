class PaymentsController < ApplicationController

    before_action :set_payment, only: [:show, :edit, :update, :destroy]

  # GET /attachments
  # GET /attachments.json
  def index
    if logged_in?
      @payments = Payment.all
    else
      redirect_to home_path
    end
  end

  def show
  end

  # GET /attachments/new
  def new
    @payment = Payment.new
  end

  # GET /attachments/1/edit
  def edit
  end

  # POST /attachments
  # POST /attachments.json
  def create
    @payment = Payment.new(attachment_params)

    if @attachment.save
      redirect_to payments_path, notice: "Successfully created payment."
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /attachments/1
  # PATCH/PUT /attachments/1.json
  def update
    if @payment.update(payment_params)
      redirect_to payments_path, notice: "Successfully updated payment."
    else
      render action: 'edit'
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.json
  def destroy
    @payment.destroy
    redirect_to payments_path, notice: "Successfully removed payment."
  end

  private
  def set_attachment
    @payment = Payment.find(params[:id])
  end

  def attachment_params
    params.require(:payment).permit(:paymnet_type, :payable_to, :amount, :case_id, :description)
  end

end
