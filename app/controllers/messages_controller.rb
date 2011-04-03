class MessagesController < ApplicationController

  # POST /messages
  # POST /messages.xml
  def createglobalmessage
    @message = Message.new
    @message.message = params[:g_message]
    @message.user_id_from = params[:from]

    @gconversation = Message.find_all_by_user_id_to(nil)

    respond_to do |format|
      if @message.save
        format.html { redirect_to(seats_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end 

  # POST /messages
  # POST /messages.xml
  def showprivatechat 
    @messages =  Message.find_all_by_user_id_to(params[:to])  
    
    @messages.each do |m|   
        @conversation = "#{@conversation}\n#{m.created_at.localtime}:#{m.user_id_from}:#{m.message}"
    end
    
    respond_to do |format|
      format.html # showprivatechat.html.erb
      format.xml  { render :xml => @message }
    end
  end
  
  
  # GET /messages
  # GET /messages.xml
  def index
    @messages = Message.all
    #fromID = params[:from]
    #toId = params[:to]
    #@conversation = Message.find_all_by_user_id_from_and_user_id_to(fromID, toID)
    @conversation = Message.all
    #Message.all.each {|m| @conversation << m.message if m.nil?}
    #@conversation = Message.first.message


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new

    respond_to do |format|
      format.html #{ redirect_to (messages_url) } # index.html.erb #  new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.xml
  def create
    @message = Message.new
    @message.message = params[:message]
    @message.user_id_from = params[:from]
    @message.user_id_to = params[:to]

    respond_to do |format|
      if @message.save
        format.html { redirect_to(showprivatechat_path) }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to(@message, :notice => 'Message was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.xml  { head :ok }
    end
  end
end
