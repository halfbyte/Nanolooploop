class LoopsController < ApplicationController
    before_filter :login_required, :only => [:destroy, :update, :edit]
    before_filter :load_user_or_deny, :except => [:latest, :top]
    skip_before_filter :set_iphone_view, :only => [:open]

    # GET /loops
    # GET /loops.xml
    def index
      if (current_user == @user)
        @loops = @user.loops.all
      else
        @loops = @user.loops.all(:public => true)
      end

      respond_to do |format|
        format.html # index.html.erb
        format.iphone
        format.xml  { render :xml => @loops }
      end
    end

    # GET /loops/1
    # GET /loops/1.xml
    def show
      @loop = @user.loops.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.iphone
        format.xml  { render :xml => @loop }
        format.nan { render :text => @loop.nan.read, :type=> 'application/octet-stream'}
      end
    end

    def open
      @loop = Loop.find(params[:id])
      render :layout => 'simple'
      # redirect_to nanoloop_url(@loop)
    end

    # GET /loops/1/edit
    def edit
      @loop = @user.loops.find(params[:id])
    end

    # PUT /loops/1
    # PUT /loops/1.xml
    def update
      @loop = @user.loops.find(params[:id])

      respond_to do |format|
        if @loop.update_attributes(params[:loop])
          flash[:notice] = 'Loop was successfully updated.'
          format.html { redirect_to(@loop) }
          format.iphone { redirect_to(@loop)}
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @loop.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /loops/1
    # DELETE /loops/1.xml
    def destroy
      @loop = @user.loops.find(params[:id])
      @loop.destroy

      respond_to do |format|
        format.html { redirect_to(loops_url) }
        format.iphone { redirect_to(loops_url)}
        format.xml  { head :ok }
      end
    end

  # some exclusive iphone lists

    def latest
      @loops = Loop.latest
      render 'list'
    end

    def top
      @loops = Loop.latest
      render 'list'
    end

  private
    def load_user_or_deny
      if (params[:user_id])
        @user = User.find(params[:user_id])
      elsif(logged_in?)
        @user = current_user
      else
        login_required
      end
    end

end
