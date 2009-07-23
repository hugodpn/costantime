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



  def profit
    @people = Person.all
    @projects = Project.all
    @graph = open_flash_chart_object(600,300,"/person_projects/graph_code/#{params[:requested_date]}")

    @requested_date = Date.civil(params[:requested_date][0..3].to_i, params[:requested_date][5..6].to_i, 1)

    @from = @requested_date - 1
    @to =  @requested_date >> 1

    @historic_projects = HistoricProject.find(:all, :conditions => ["historic_date > ? and historic_date < ?", @from, @to])
    
  end

  def graph_code

    puts params.inspect
    
    # based on this example - http://teethgrinder.co.uk/open-flash-chart-2/data-lines-2.php
    # and parts from this example - http://teethgrinder.co.uk/open-flash-chart-2/x-axis-labels-3.php
    title = Title.new("PERSON - PROFIT (lasted 3 months)")

    data1 = []
    data2 = []
    data3 = []

    5.times do |x|
      data1 << rand(5) + 1
      data2 << rand(6) + 7
      data3 << rand(5) + 14
    end

    line_dot = LineDot.new
    line_dot.width = 4
    line_dot.colour = '#DFC329'
    line_dot.dot_size = 5
    line_dot.values = data1

    line_hollow = LineHollow.new
    line_hollow.width = 1
    line_hollow.colour = '#6363AC'
    line_hollow.dot_size = 5
    line_hollow.values = data2

    line = Line.new
    line.width = 1
    line.colour = '#5E4725'
    line.dot_size = 5
    line.values = data3

    # Added these lines since the previous tutorial
    tmp = []
    x_labels = XAxisLabels.new
    x_labels.set_vertical()

    %w(one two three four five).each do |text|
      tmp << XAxisLabel.new(text, '#0000ff', 20, 'diagonal')
    end

    x_labels.labels = tmp

    x = XAxis.new
    x.set_labels(x_labels)
    # new up to here ...

    y = YAxis.new
    y.set_range(0,20,5)

    x_legend = XLegend.new("Months")
    x_legend.set_style('{font-size: 20px; color: #778877}')

    y_legend = YLegend.new("MY Y Legend")
    y_legend.set_style('{font-size: 20px; color: #770077}')

    chart =OpenFlashChart.new
    chart.set_title(title)
    chart.set_x_legend(x_legend)
    chart.set_y_legend(y_legend)
    chart.x_axis = x # Added this line since the previous tutorial
    chart.y_axis = y

    chart.add_element(line_dot)
    chart.add_element(line_hollow)
    chart.add_element(line)

    render :text => chart.to_s
  end


  def update

    Person.all.each do |person|
      person.set_cost(params["person_#{person.id}"], params["requested_date"])
      
      Project.all.each do |project|
        project.set_income(params["project_#{project.id}"], params["requested_date"])
        PersonProject.set_person_project(person.id, project.id, params["person_project_#{person.id}_#{project.id}"], params["requested_date"])
      end
      
    end

    redirect_to("/person_projects/profit/#{params[:requested_date]}")

  end


end