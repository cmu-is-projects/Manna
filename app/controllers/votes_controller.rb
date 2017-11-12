class VotesController < ApplicationController
  before_action :set_vote, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def index
    @votes = Vote.all
  end

  def show
  end

  def new
    # @case = Case.find(params[:case_id])
    @vote = Vote.new
    # authorize! :new, @vote
    @vote.case_id = params[:id] unless params[:id].nil?
  end

  def edit
  end



  def create

    # @case = Case.find(params[:case_id]) # case_id is passed in the URL
    # @vote = @case.build(params[:vote])

    @vote = Vote.new(vote_params)
    authorize! :create, @vote
    @vote.deacon_id = current_user.id
    # @vote.case_id = params[:case_id] unless params[:case_id].nil?
    @vote.date_submitted = Date.current
    @vote.case_id = params[:id] unless params[:id].nil?

    if @vote.save
      redirect_to votes_path, notice: "Successfully created vote."
    else
      render action: 'new'
    end
  end

  def update
    if @vote.update(vote_params)
      redirect_to votes_path, notice: "Successfully updated vote."
    else
      render action: 'edit'
    end
  end


  def destroy
    @vote.destroy
    redirect_to votes_path, notice: "Successfully removed vote: #{@vote.decision} from the system."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.require(:vote).permit(:deacon_id, :decision, :case_id)
    end
end
