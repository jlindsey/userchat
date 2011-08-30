class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    
    if @user.update_attributes(params[:user])
      flash[:success] = "Account info updated successfully"
    else
      flash[:error] = "Error updating account info"
    end

    redirect_to account_url
  end
end
