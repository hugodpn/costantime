class PersonProjectController < ApplicationController

  def index
    @person_project = PersonProject.all
    @people = Person.all
    @projects = Project.all
  end

  # DELETE /person_project/1
  # DELETE /person_project/1.xml
  def destroy
    @person_project = PersonProject.find(params[:id])
    @person_project.destroy

    respond_to do |format|
      format.html { redirect_to("/person_project") }
      format.xml  { head :ok }
    end
  end

end