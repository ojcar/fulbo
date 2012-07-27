class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  before_filter :login_required, :only => [:my_profile]
  
  def show
    #@user = User.find(params[:id])
    @user = User.find_by_login(params[:login])
  end
  
  def show_by_login
    @user = User.find_by_login(params[:login])
    render :action => 'show'
  end

  def my_profile
    #@user = User.find_by_login(params[:login])
    #@group = Group.find(@current_user.groups)
    @groups = Group.find(:all)
    @countries = Country.find(:all)
  end

# returns all members of the same group
  def show_by_group
    #@group = Group.find(params[:id]) # later change to read group name instead
    @group = Group.find_by_name(params[:name])
    @users = User.find(@group.users)
  end

# @entries = Entry.find(:all, :conditions => ["entry.group.name = ?", group])

  # render new.rhtml
  def new
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.save
    if @user.errors.empty?
      self.current_user = @user
      redirect_back_or_default('/')
      flash[:notice] = "Registro completo. Bienvenido al campo de juego!"
    else
      render :action => 'new'
    end
  end
  
  def forgot
    if request.post?
      user = User.find_by_email(params[:user][:email])
      if user
        user.create_reset_code
        flash[:notice] = "Reset code sent to #{user.email}"
      else
        flash[:notice] = "#{params[:user][:email]} does not exist in system"
      end
      redirect_back_or_default('/')
    end
  end
  
  def reset
    @user = User.find_by_reset_code(params[:reset_code]) unless params[:reset_code].nil?
    if request.post?
      if @user.update_attributes(:password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
        self.current_user = @user
        @user.delete_reset_code
        flash[:notice] = "Password reset successfully for #{@user.email}"
        redirect_back_or_default('/')
      else
        render :action => :reset
      end
    end
  end
  

end
