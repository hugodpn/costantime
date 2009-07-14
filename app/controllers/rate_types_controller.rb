class RateTypesController < ApplicationController
  # GET /rate_types
  # GET /rate_types.xml
  def index
    @rate_types = RateType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rate_types }
    end
  end

  # GET /rate_types/1
  # GET /rate_types/1.xml
  def show
    @rate_type = RateType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rate_type }
    end
  end

  # GET /rate_types/new
  # GET /rate_types/new.xml
  def new
    @rate_type = RateType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rate_type }
    end
  end

  # GET /rate_types/1/edit
  def edit
    @rate_type = RateType.find(params[:id])
  end

  # POST /rate_types
  # POST /rate_types.xml
  def create
    @rate_type = RateType.new(params[:rate_type])

    respond_to do |format|
      if @rate_type.save
        flash[:notice] = 'RateType was successfully created.'
        format.html { redirect_to(@rate_type) }
        format.xml  { render :xml => @rate_type, :status => :created, :location => @rate_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rate_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rate_types/1
  # PUT /rate_types/1.xml
  def update
    @rate_type = RateType.find(params[:id])

    respond_to do |format|
      if @rate_type.update_attributes(params[:rate_type])
        flash[:notice] = 'RateType was successfully updated.'
        format.html { redirect_to(@rate_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rate_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rate_types/1
  # DELETE /rate_types/1.xml
  def destroy
    @rate_type = RateType.find(params[:id])
    @rate_type.destroy

    respond_to do |format|
      format.html { redirect_to(rate_types_url) }
      format.xml  { head :ok }
    end
  end
end
