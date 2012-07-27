class GroupsController < ApplicationController
  before_filter :login_required, :only => [ :join ]

  def index
  	@entries = Entry.find(:all, :conditions => ["group_id != ?", "1"],:order => 'created_at DESC', :limit => 5)
    @blogentries = Entry.find(:all, :conditions => {:group_id => "1"},:order => 'created_at DESC', :limit => 5)
    #@entries = Entry.paginate(:page => params[:page], :conditions => ["group_id != ?", "5"],:order => 'created_at DESC', :per_page => 5)
    #@blogentries = Entry.paginate(:page => params[:page], :conditions => {:group_id => "5"},:order => 'created_at DESC', :per_page => 5)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @entries }
      format.rss  { render :action => 'rss.rxml', :layout => false }
      format.atom  { render :action => 'atom.rxml', :layout => false }
    end 
  end

  def show
    #group = @params[:id]
    #@entries = Entry.find(:all, :conditions => ["entry.group_id = ?", group])
    #@group = Group.find(params[:id])

    @group = Group.find_by_name(params[:name])
	
	if @group.name == "fulbo"
		@blogentries = Entry.paginate(:page => params[:page], :conditions => {:group_id => "5"},:order => 'created_at DESC', :per_page => 5)
	else
    	@entries = @group.entries.paginate(:page => params[:page], :order => 'created_at DESC', :per_page => 5)
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @entries }
      format.rss  { render :action => 'rss.rxml', :layout => false }
      format.atom  { render :action => 'atom.rxml', :layout => false }
    end 
  end

  def show_by_name
    #group = @params[:name]
    #@entries = Entry.find(:all, :conditions => ["entry.group.name = ?", group])
    @group = Group.find_by_name(params[:name])
    #@entries = @group.entries.find(:all)
    @entries = @group.entries.paginate(:page => params[:page], :order => 'created_at DESC', :per_page => 5) 
    render :action => 'show' 
  end
  
  
  
  # -
  # reads a url like domain.com/group/join/1
  # the user is trying to join a group. the user can join if he/she doesnt belong
  # to a group with the same country
  # -
  
      #@user = User.find(params[:user_id])
    #@group_wanted = Group.find(params[:id]) # later change to params[:name]
    #matches = Group.find(:first, :conditions => ["country_id = ? AND  = ?", @group_wanted.country_id, current_user])
    #matches = Group.find_by_sql(["SELECT * from groups, users WHERE groups.country_id = ? AND users.id = ?", @group_wanted.country_id, current_user.id])  
    #country_wanted = Country.find(:first, :conditions => ["group_id = ? ", group_wanted])
    #group_user_has = Group.find(:first, :conditions => ["country_id = ?", country_wanted.id])
    #match = Group.find(:first, :conditions => ["user_id = ? AND country_id = ?", current_user, country_wanted.country_id]
    
    
    #if matches.empty? #@user.has_group?(group_user_has)
      #current_user.groups << @group_wanted
    #  flash[:notice] = "Joined!"
    #  redirect_to :action => 'index'
    #else
    #  flash[:error] = "Already have one in the same country"
    #  redirect_to :action => 'index'
    #end
    #else
    #  redirect_to :action => 'index'
    #end
    
    #groups.find_by_name(groupname) ? true : false
    
  def join
    if logged_in?
      @group_wanted = Group.find(params[:id]) # later change to params[:name]
      @country_wanted = Country.find(@group_wanted.country_id, :limit => 1)
      #match = current_user.countries.find(@country_wanted.id)
      #unless current_user.has_country?(@country_wanted.id) #countries.find(@country_wanted.id)
      #@matches = current_user.countries
      @match = Country.find_by_sql(["SELECT * FROM countries_users WHERE user_id = ? AND country_id = ?", current_user.id, @country_wanted.id])
      if @match.empty? #current_user.countries.find(@country_wanted.id).nil? #current_user.has_country?(@country_wanted.id) 
        flash[:notice] = "Joined!"
        current_user.groups << @group_wanted # add group
        current_user.countries << @country_wanted # add country
        redirect_to '/perfil'
      else
        flash[:error] = "You're either already subscribed to a group in the same country or in the same group."
        redirect_to :action => 'index'
      end 
    end 
  end
  
  def baja 
  	if logged_in?
  		@group_wanted = Group.find(params[:id]) # later change to params[:name]
     	@country_wanted = Country.find(@group_wanted.country_id, :limit => 1)
     	current_user.groups.delete(@group_wanted) # remove group
        current_user.countries.delete(@country_wanted) # remove country
        redirect_to '/perfil'
  	end
  end
  
  def show_all_users
    #@group = Group.find(params[:id]) # later change to read group name instead
    @group = Group.find_by_name(params[:name])
    @users = User.find(@group.users)
  end
  
end
