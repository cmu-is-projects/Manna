class HomeController < ApplicationController

  def home
    
    @all_cases = Case.chronological.paginate(page: params[:page]).per_page(10)
    @cases_current_user = Case.for_deacon(current_user.id).chronological.paginate(page: params[:page]).per_page(10)
    @cases_need_voting = Case.not_voted_by_deacon(current_user)
    
    # if logged_in?
    #   if current_user.role? :care_deacon
    #     @cases_user = Case.for_deacon(current_user.id).chronological.paginate(page: params[:page]).per_page(10)
    #   elsif (current_user.role? :admin) || (current_user.role? :head_deacon)
    #     @cases_need_voting = Case.not_voted_by_deacon(current_user)
    #     @check_processed_cases = Case.check_processed.chronological.paginate(page: params[:page]).per_page(10)
    #     @submitted_cases = Case.submitted.chronological.paginate(page: params[:page]).per_page(10)
    #   elsif current_user.role? :staff
    #     @all_cases = Case.chronological.paginate(page: params[:page]).per_page(10)
    #     @approved_cases = Case.approved.chronological.paginate(page: params[:page]).per_page(10)
    #   elsif current_user.role? :financial_deacon
    #     @submitted_cases = Case.submitted.chronological.paginate(page: params[:page]).per_page(10)
    #     @cases_need_voting = Case.not_voted_by_deacon(current_user)
    #   end
    # end
    # @filterrific = initialize_filterrific(
    #   Case,
    #   params[:filterrific]
    # ) or return
    # @all_cases = @filterrific.find.page(params[:page])

    # respond_to do |format|
    #   format.html
    #   format.js
    # end

  end

  def apply
  end

  def cases
  end

  def clients
    @all_cases = Case.client_alphabetical.chronological.paginate(page: params[:page]).per_page(10)
  end
end
