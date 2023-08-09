class RelationsController < ApplicationController
  
  def create
    current_user.follow.create(followed_id: params[:user_id])
    redirect_to request.referer
  end
  
  def destroy
    current_user.follow.find_by(followed_id: params[:user_id]).destroy
    redirect_to request.referer
  end

end
