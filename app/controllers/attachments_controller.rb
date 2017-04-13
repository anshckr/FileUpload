class AttachmentsController < ApplicationController
  before_action :authorize
  before_action :set_attachment, only: [:show, :destroy]

  def index
    @attachments = current_user.attachments
  end

  def show
    send_data(@attachment.data,
              type: @attachment.content_type,
              filename: @attachment.filename)
  end

  def new
    @attachment = current_user.attachments.build
  end

  def create
    @attachment = current_user.attachments.build(attachment_params)

    respond_to do |format|
      if @attachment.save
        flash[:notice] = "Successfully created new attachment"
        redirect_to user_attachments_path current_user.id
      else
        render :action => 'new'
      end
    end
  end

  def destroy
    @attachment.destroy
    respond_to do |format|
      format.html { redirect_to user_attachments_path current_user.id }
      format.json { head :no_content }
    end
  end

  private
  def set_attachment
    @attachment = current_user.attachments.find(params[:id])
  end

  def attachment_params
    params.require(:attachment).permit(:file)
  end
end
