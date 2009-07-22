class HistoricCostsController < ApplicationController
  before_filter :load_selects, :only => [:new, :edit, :create, :update ]

  def load_selects
    @people = Person.find(:all)
  end

  # GET /historic_costs
  # GET /historic_costs.xml
  def index
    @historic_costs = HistoricCost.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @historic_costs }
    end
  end

  # GET /historic_costs/1
  # GET /historic_costs/1.xml
  def show
    @historic_cost = HistoricCost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @historic_cost }
    end
  end

  # GET /historic_costs/new
  # GET /historic_costs/new.xml
  def new
    @historic_cost = HistoricCost.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @historic_cost }
    end
  end

  # GET /historic_costs/1/edit
  def edit
    @historic_cost = HistoricCost.find(params[:id])
  end

  # POST /historic_costs
  # POST /historic_costs.xml
  def create
    @historic_cost = HistoricCost.new(params[:historic_cost])

    respond_to do |format|
      if @historic_cost.save
        flash[:notice] = 'HistoricCost was successfully created.'
        format.html { redirect_to(new_historic_project_path) }
        format.xml  { render :xml => @historic_cost, :status => :created, :location => @historic_cost }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @historic_cost.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /historic_costs/1
  # PUT /historic_costs/1.xml
  def update
    @historic_cost = HistoricCost.find(params[:id])

    respond_to do |format|
      if @historic_cost.update_attributes(params[:historic_cost])
        flash[:notice] = 'HistoricCost was successfully updated.'
        format.html { redirect_to(new_historic_project_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @historic_cost.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /historic_costs/1
  # DELETE /historic_costs/1.xml
  def destroy
    @historic_cost = HistoricCost.find(params[:id])
    @historic_cost.destroy

    respond_to do |format|
      format.html { redirect_to(new_historic_costs_path) }
      format.xml  { head :ok }
    end
  end
end
