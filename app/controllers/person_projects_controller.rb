class PersonProjectsController < ApplicationController

  def index
    @person_project = PersonProject.all
    @people = Person.all
    @projects = Project.all
  end

  # DELETE /person_project/1
  # DELETE /person_project/1.xml
  def destroy
    puts params.inspect
    @person_project = PersonProject.find(params[:id])
    @person_project.destroy

    respond_to do |format|
#      format.html { redirect_to("/person_project") }
      format.html { redirect_to("/person_projects/new/#{params[:person_id]}") }
      format.xml  { head :ok }
    end
  end

  def new
    @person_project = PersonProject.new
    @person = Person.find(params[:id])
    @projects = Project.all
  end

  def create
    @person_project = PersonProject.new(params[:person_project])
    @person = Person.find(params[:person_project][:person_id])
    @projects = Project.all

    respond_to do |format|
      if @person_project.save
        flash[:notice] = 'Person - Project was successfully created.'
        format.html { redirect_to("/person_projects/new/#{params[:person_project][:person_id]}") }
        format.xml  { render :xml => @person_project, :status => :created, :location => @person_project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @person_project.errors, :status => :unprocessable_entity }
      end
    end
  end


end