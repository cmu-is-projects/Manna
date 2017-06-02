class HomeController < ApplicationController

  def home
    if logged_in?
      if current_user.role?('care deacon')
        @cases_user = Case.for_deacon(current_user.id).chronological.paginate(page: params[:page]).per_page(10)
      else
        @need_review = Case.submitted.paginate(page: params[:page]).per_page(10)
        @reviewed = Case.reviewed.paginate(page: params[:page]).per_page(10)
      end
    end
  end

  def apply
  end

  def cases
  end

  def clients
  end
end
