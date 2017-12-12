class HomeController < ApplicationController

  def home
    
    @all_cases = Case.chronological_reverse.paginate(page: params[:page]).per_page(10)
    @years = [Time.now.year]
    # Array.new(Time.now.year)
    @cases_current_user = Case.for_deacon(current_user.id).chronological.paginate(page: params[:page]).per_page(10)
    @cases_need_voting = Case.not_voted_by_deacon(current_user)
    

  end

  def apply
  end

  def cases
  end

  def clients
    @all_cases = Case.client_alphabetical.chronological.paginate(page: params[:page]).per_page(10)
  end
end
