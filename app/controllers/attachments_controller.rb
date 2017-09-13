class AttachmentsController < ApplicationController
  before_action :set_attachment, only: [:show, :edit, :update, :destroy]

  # GET /attachments
  # GET /attachments.json
  def index
    if logged_in?
      @attachments = Attachment.all
    else
      redirect_to home_path
    end
  end

  def show
  end

  # GET /attachments/new
  def new
    @attachment = Attachment.new
  end

  # GET /attachments/1/edit
  def edit
  end

  # POST /attachments
  # POST /attachments.json
  def create
    @attachment = Attachment.new(attachment_params)

    if @attachment.save
      redirect_to attachments_path, notice: "Successfully created attachment."
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /attachments/1
  # PATCH/PUT /attachments/1.json
  def update
    if @attachment.update(attachment_params)
      redirect_to attachments_path, notice: "Successfully updated attachment."
    else
      render action: 'edit'
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.json
  def destroy
    @attachment.destroy
    redirect_to attachments_path, notice: "Successfully removed attachment."
  end

  private
  def set_attachment
    @attachment = Attachment.find(params[:id])
  end

  def attachment_params
    params.require(:attachment).permit(:name, :doc)
  end
end
