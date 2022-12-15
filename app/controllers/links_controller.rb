class LinksController < ApplicationController
  
  def show
    @link = Link.find_by_slug(params[:slug]) 
    redirect_to root_path if @link.nil? 
    @link.update_attribute(:clicked, @link.clicked + 1)
    redirect_to @link.url
  end
  
end