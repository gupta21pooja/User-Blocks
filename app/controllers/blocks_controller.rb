class BlocksController < ApplicationController
  # GET /blocks
  # GET /blocks.xml
  before_filter :authenticate
  before_filter :load_block , :except => [:index]
  before_filter :has_premission?, :only => [:destroy,:edit]

  def index
    @blocks = Block.public_blocks.page(params[:page]).per(1)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @blocks }
    end
  end

  # GET /blocks/1
  # GET /blocks/1.xml
  def show
    @block = Block.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @block }
    end
  end

  # GET /blocks/new
  # GET /blocks/new.xml
  def new
    @block = Block.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @block }
    end
  end

  # GET /blocks/1/edit
  def edit
    @block = Block.find(params[:id])
  end

  # POST /blocks
  # POST /blocks.xml
  def create
    @block = Block.new(params[:block])
    @block.user_session = user_session
    respond_to do |format|
      if @block.save
        format.html { redirect_to(@block, :notice => 'Block was successfully created.') }
        format.xml  { render :xml => @block, :status => :created, :location => @block }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @block.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /blocks/1
  # PUT /blocks/1.xml
  def update
    @block = Block.find(params[:id])
    respond_to do |format|
      if @block.update_attributes(params[:block])
        format.html { redirect_to(@block, :notice => 'Block was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @block.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /blocks/1
  # DELETE /blocks/1.xml
  def destroy
    @block = Block.find(params[:id])
    if @user_session == @block.user_session
      respond_to do |format|
        format.html { redirect_to(blocks_url) }
        format.xml  { head :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to(blocks_url) }
        format.xml  { render :xml => "you cann't delete", :status => :unprocessable_entity }
      end
    end
  end
  protected

  def authenticate
    if params[:session_id]
      session[:session_id] = params[:session_id]
      @user_session = UserSession.find_or_create_by(:session_id => session[:session_id])
    else
      
    end    
  end
  
  def has_premission?
    unless @user_session && !@block.is_owner?(@user_session)
      redirect_to :back and return true
    end
  end
  
  def load_block
    if params[:id]
      @block  = Block.find(params[:id])
    else
      @block = Block.new(params[:block])
    end
  end  

end
