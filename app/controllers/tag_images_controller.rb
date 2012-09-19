class TagImagesController < ApplicationController

  before_filter :authorize

  respond_to :json

  def index
    Rails.logger.debug "Entering index action"
    @tag_images = TagImage.all
    respond_with @tag_images, :location => nil
  end

  def show
    @tag_image = TagImage.find(params[:id])
    respond_with @tag_image, :location => nil
  end

  def create

    tag_image = params[:tag_image]

    stringio = TagImageStringIO.new(Base64.decode64(tag_image[:image]))
    stringio.original_filename = tag_image[:filename]

    @tag_image = TagImage.new
    @tag_image.image = stringio

    if @tag_image.save
      flash[:notice] = 'Tag image was successfully created.'
    else
      flash[:error] = @tag_image.errors
    end

    respond_with @tag_image, location: nil

  end

  def update

    tag_image = params[:tag_image]

    @tag_image = TagImage.find(params[:id])

    stringio = TagImageStringIO.new(Base64.decode64(tag_image[:image]))
    stringio.original_filename = tag_image[:filename]

    @tag_image.image = stringio

    if @tag_image.save
      Rails.logger.debug "update save succeeded"
      flash[:notice] = 'Tag image was successfully updated.'
    else
      flash[:error] = @tag_image.errors
    end

    head :no_content

  end

  def destroy
    @tag_image = TagImage.find(params[:id])
    @tag_image.destroy
    head :no_content
  end

end
