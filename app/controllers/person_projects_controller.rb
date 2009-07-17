class PersonProjectsController < ApplicationController

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
      #      format.html { redirect_to("/person_project") }
      format.html { redirect_to("/person_projects/new/#{params[:requested_date]}") }
      format.xml  { head :ok }
    end
  end

  def new

    @person_project = PersonProject.new
    @person_project.date_worked = params[:id]

    @requested_date = Date.new(@person_project.date_worked.year, @person_project.date_worked.month, 1)

    @from = @requested_date - 1
    @to =  @requested_date >> 1


    @people = Person.all
    @projects = Project.all
  end



  def create


    @person_project = PersonProject.new(params[:person_project])
    @people = Person.all
    @projects = Project.all

    @requested_date = Date.civil(params[:person_project][:"date_worked(1i)"].to_i,params[:person_project][:"date_worked(2i)"].to_i,params[:person_project][:"date_worked(3i)"].to_i)

    @from = @requested_date - 1
    @to =  @requested_date >> 1


    respond_to do |format|
      if @person_project.save
        flash[:notice] = 'Person - Project was successfully created.'
        format.html { redirect_to("/person_projects/new/#{@requested_date}") }
        format.xml  { render :xml => @person_project, :status => :created, :location => @person_project }
      else
        format.html { render :action => "new", :id => params[:person_project][:date_worked] }
        format.xml  { render :xml => @person_project.errors, :status => :unprocessable_entity }
      end
    end
  end


  def report_profit

    @requested_date = Date.civil(params[:requested_date][0..3].to_i, params[:requested_date][5..6].to_i, 1)

    @from = @requested_date - 1
    @to =  @requested_date >> 1

    @historic_projects = HistoricProject.find(:all, :conditions => ["historic_date > ? and historic_date < ?", @from, @to])
    

  end

end