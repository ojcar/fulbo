class EntriesController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  before_filter :get_group
  
  # GET /entries
  # GET /entries.xml
  def index
    #@entries = Entry.find(:all)
    #@entries = @group.entries.find(:all)
    @entries = @group.entries.paginate(:page => params[:page], :order => 'created_at DESC', :per_page => 5)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entries }
    end
  end

 # EXAMPLE FROM GROUPS CONTROLLER
 # def show_by_name
 #   group = @params[:name]
 #   @entries = Entry.find(:all, :conditions => ["entry.group.name = ?", group])
 #   render :action => 'show'
 # end


  # GET /entries/1
  # GET /entries/1.xml
  def show
    @entry = Entry.find(params[:id])
    # @entry = Entry.find_by_permalink(params[:permalink])
    @comments = @entry.comments.find(:all)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @entry }
    end
  end

  def newtexto
    @entry = Texto.new
    #render :partial => "newtexto"
  end
  
  def newlink
    @entry = Link.new
    #render :partial => "newlink"
  end
  
  def newphoto
    @entry = Photo.new
    #render :partial => "newphoto"
  end
  
  def newquote
    @entry = Quote.new
    #render :partial => "newquote"
  end
    
  # GET /entries/new
  # GET /entries/new.xml
  def new
    case params[:entry_type]
      when "Texto"
        @entry = Texto.new
        render :action => "newtexto"
      when "Link"
        @entry = Link.new
        render :action => "newlink"
      when "Photo"
        @entry = Photo.new
        render :action => "newphoto"
      when "Quote"
        @entry = Quote.new
        render :action => "newquote"
    end  
    #@entry = Entry.new # leave only this line if no subclasses are to be used; delete "case" loop below
    #respond_to do |format|
    #  format.html # new.html.erb
    #  format.xml  { render :xml => @entry }
    #end
  end

  # GET /entries/1/edit
  def edit
    @entry = Entry.find(params[:id])
  end

  # POST /entries
  # POST /entries.xml
  def create
    #@entry = Entry.new(params[:entry]) # leave only this line if subclasses are not to be used, and delete "case" loop below
    case params[:entry_type]
      when "Texto"
        @entry = Texto.new(params[:entry])
      when "Link"
        @entry = Link.new(params[:entry])
      when "Photo"
        @entry = Photo.new(params[:entry])
      when "Quote"
        @entry = Quote.new(params[:entry])
    end
    
    #@entry = Texto.new(params[:entry])
    #@entry.type = @params[:type]
    
    @entry.group_id = @group.id # save group id to the entry
    
    #@mygroup = Group.find_by_name(params[:group_id]) #horrible hack because get_group stop working
    #@entry.group_id = @mygroup.id
    
    @entry.user_id = current_user.id # need to add user_id to the entry

    respond_to do |format|
      if @entry.save
        flash[:notice] = 'Entry was successfully created.'
        format.html { redirect_to group_entry_url(@group.name,@entry) } # was: redirect_to(@entry) 
        format.xml  { render :xml => @entry, :status => :created, :location => @entry }
      else
        case params[:entry_type]
          when "Texto"
            format.html { render :action => "newtexto", :layout => "application" }
          when "Link"
            format.html { render :action => "newlink", :layout => "application" }
          when "Photo"
            format.html { render :action => "newphoto", :layout => "application" }
          when "Quote"
            format.html { render :action => "newquote", :layout => "application" }
        end       
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.xml
  def update
    @entry = Entry.find(params[:id])

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        flash[:notice] = 'Entry was successfully updated.'
        format.html { redirect_to(@group,@entry) } # was redirect_to(@entry)
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.xml
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to(entries_url) }
      format.xml  { head :ok }
    end
  end
  
  def vote
    return unless logged_in?
      @entry = Entry.find(params[:id])
      unless @entry.voted_by_user?(current_user)
        @vote = Vote.new(:vote => params[:vote] == "for")
        @vote.user_id = current_user.id
        @entry.votes << @vote
      end
  end
  
  private
  def get_group
    @group = Group.find_by_name(params[:group_id]) # need to have group_id otherwise "create" does not work
    #@group = Group.find_by_name(params[:name])
    #@group = Group.find(params[:group_id])
  end
  
end
