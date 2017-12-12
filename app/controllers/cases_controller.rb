class CasesController < ApplicationController
  before_action :set_case, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource

  # GET /cases
  # GET /cases.json
  def index
    if logged_in?
      @years = []
      if !Case.all.empty?
        @var = Case.earliest_date.to_a[0].date_submitted.year
        while(@var <= Time.now.year)
          @years.insert(0, @var)
          @var += 1
        end
      end
    end
    # if logged_in, can only see own if care_d or can see all of them if financial_d
    if logged_in?

      if current_user.role?(:care_deacon)
        if params[:search]
          search_cases_for(params[:search])
        else 
          @cases = Case.for_deacon(current_user.id).chronological.paginate(page: params[:page]).per_page(10)
        end
      else
        if params[:search]
          search_cases_for(params[:search])
        else
          @cases = Case.chronological.paginate(page: params[:page]).per_page(10)
        end
      end

      @cases_need_voting = Case.not_voted_by_deacon(current_user)
      @total_amt_approved = Case.total_amt_approved()
      
    else
      redirect_to home_path
    end



  end

  # GET /cases/1
  # GET /cases/1.json
  def show
    @attachments_list = @case.attachments.all
    @payments_list = @case.payments.all
  end

  # GET /cases/new
  def new
    @case = Case.new
    @case.attachments.build
    @case.payments.build
    # @case.votes.case_id = self.id
    @case.votes.build
  end

  # GET /cases/1/edit
  def edit
  end

  # POST /cases
  # POST /cases.json
  def create

    @case = Case.new(case_params)
    if @case.save
      # save payments
      # num_payments = params[:case][:payments_attributes].count
      # for item in params[:case][:payments_attributes]
      #   p = Payment.new
      #   p.case_id = @case.id
      #   p.payment_type = item[:payment_type]
      #   p.payable_to = item[:payable_to]
      #   p.description = item[:description]
      #   p.amount = item[:amount]
      #   p.save!
      # end
      # num_payments.times do |i|
      #   p = Payment.new
      #   p.case_id = @case.id
      #   p.payment_type = params[:case][:payments_attributes][i.to_s][:payment_type]
      #   p.payable_to = params[:case][:payments_attributes][i.to_s][:payable_to]
      #   p.description = params[:case][:payments_attributes][i.to_s][:description]
      #   p.amount = params[:case][:payments_attributes][i.to_s][:amount]
      #   p.save!
      # end

      # if saved to database
      flash[:notice] = "Successfully created case: #{@case.subject} for #{@case.client_name}."
      redirect_to @case # go to show case page
    else
      # return to the 'new' form
      render action: 'new'
    end
  end

  # PATCH/PUT /cases/1
  # PATCH/PUT /cases/1.json
  def update
    if @case.update(case_params)
      redirect_to case_path(@case), notice: "Successfully updated case: #{@case.subject} for #{@case.client_name}."
    else
      render action: 'edit'
    end
  end

  # DELETE /cases/1
  # DELETE /cases/1.json
  def destroy
    @case.destroy
    flash[:notice] = "Successfully removed case: #{@case.subject} for #{@case.client_name} from the system."
    redirect_to cases_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_case
      @case = Case.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def case_params
      params.require(:case).permit(:client_name, :client_first_name, :subject, :notes, :recommendation, :amount_requested, :amount_approved, :date_submitted, :summary, :status, :deacon_id, :attachment_ids => [], \
        attachments_attributes: [:id, :name, :doc, :remove_doc, :_destroy], \
        payments_attributes: [:id, :payment_type, :payable_to, :amount, :case_id, :description, :pay_by])
    end

    def search_cases_for(query)
      @cases = Case.search(query).chronological.paginate(page: params[:page]).per_page(10)
      if (@cases).size == 1
        return redirect_to @cases.first
      end
    end 
  end
