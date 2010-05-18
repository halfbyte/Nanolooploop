class UsersController < ApplicationController

  before_filter :login_required, :only => [:edit, :update]


  def show
    @user = User.find(params[:id])
    if (@user == current_user)
      @loops = @user.loops.all
    else
      @loops = @user.loops.all(:conditions => {:private => false})
    end
    respond_to do |f|
      f.iphone { render :template => 'loops/index' }
      f.html
    end
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
