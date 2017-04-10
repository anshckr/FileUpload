class AttachmentsController < ApplicationController 
  before_action :authorize
  before_action :set_attachment, only: [:show, :destroy]

  def index
    @attachments = Attachment.all
  end

  def show
    send_data(@attachment.data,
              type: @attachment.content_type,
              filename: @attachment.filename)
  end

  def new
    @attachment = Attachment.new
  end

  def create
    @attachment = Attachment.new(attachment_params)

    respond_to do |format|
      if @attachment.save
        format.html { redirect_to attachments_path, notice: 'Attachment was successfully uploaded.' }
        format.json { render action: 'show', status: :created, location: @attachment }
      else
        format.html { render action: 'new' }
        format.json { render status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @attachment.destroy
    respond_to do |format|
      format.html { redirect_to attachments_url }
      format.json { head :no_content }
    end
  end

  private
  def set_attachment
  	@attachment = Attachment.find(params[:id])
  end
  
  def attachment_params
    params.require(:attachment).permit(:file)
  end
end

