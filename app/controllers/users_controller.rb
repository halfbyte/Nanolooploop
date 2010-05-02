class UsersController < ApplicationController
  
  before_filter :login_required, :only => [:edit, :update]

  skip_before_filter :set_iphone_view, :only => :show

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Saved your settings..."
      redirect_to root_path
    else
      render 'edit'
    end

  end

  def index
    @users = User.all
  end
end
