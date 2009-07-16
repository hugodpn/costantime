class HistoricProjectsController < ApplicationController
  before_filter :load_selects, :only => [:new, :edit, :create, :update ]

  def load_selects
    @projects = Project.find(:all)
  end

  # GET /historic_projects
  # GET /historic_projects.xml
  def index
    @historic_projects = HistoricProject.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @historic_projects }
    end
  end

  # GET /historic_projects/new
  # GET /historic_projects/new.xml
  def new
    @historic_project = HistoricProject.new    

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @historic_project }
    end
  end

  # GET /historic_projects/1/edit
  def edit
    @historic_project = HistoricProject.find(params[:id])    
  end

  # POST /historic_projects
  # POST /historic_projects.xml
  def create
    @historic_project = HistoricProject.new(params[:historic_project])
    
    respond_to do |format|
      if @historic_project.save
        flash[:notice] = 'HistoricProject was successfully created.'
        format.html { redirect_to(new_historic_project_path) }
        format.xml  { render :xml => @historic_project, :status => :created, :location => @historic_project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @historic_project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /historic_projects/1
  # PUT /historic_projects/1.xml
  def update
    @historic_project = HistoricProject.find(params[:id])
    
    respond_to do |format|
      if @historic_project.update_attributes(params[:historic_project])
        flash[:notice] = 'HistoricProject was successfully updated.'
        format.html { redirect_to(historic_projects_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @historic_project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /historic_projects/1
  # DELETE /historic_projects/1.xml
  def destroy
    @historic_project = HistoricProject.find(params[:id])
    @historic_project.destroy

    respond_to do |format|
      format.html { redirect_to(historic_projects_url) }
      format.xml  { head :ok }
    end
  end
end
