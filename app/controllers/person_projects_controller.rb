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

  COLORS = ["#0000FF", "#DC143C", "#ADFF2F", "#FF69B4", "#800080", "#40E0D0", "#9ACD32", "#D8BFD8", "#778899", "#FF4500"]

  def last_months(count, date, project_id)

    @requested_date = Date.civil(date[0..3].to_i, date[5..6].to_i, 1)

    @from = @requested_date - 1
    @to =  @requested_date >> 1


    months = []
    count.times do |i|
      tmp_time = @requested_date << (count - i -1)
      months << tmp_time.strftime("%Y-%m-1")
    end

    projects = []
    total = []

    if project_id == "-1"
      Project.all.each do |project|
        p = []
        p << project.name
        p << profit_months(project, months)
        p << COLORS[projects.size]
        projects << p
      end

      months.each do |month|
        requested_date = Date.civil(month[0..3].to_i, month[5..6].to_i, 1)

        from = requested_date - 1
        to =  requested_date >> 1
        total << (Project.total_income(from, to) - Person.total_cost(from, to)).to_i
      end

    else
      project = Project.find(project_id)

      p = []
      p << "Income"
      p << profit_months(project, months)
      p << COLORS[projects.size]
      projects << p

      p = []
      p << "Cost"
      p << cost_months(project, months)
      p << COLORS[projects.size]
      projects << p
      
      total = total_by_project(projects[0][1], projects[1][1])
    end

    range = range_of_data(projects, total)
    
    return projects, months, range, total

  end

  def total_by_project(incomes, costs)
    total = []
    incomes.size.times do |i|
      total <<  incomes[i] - costs[i]
    end
    total
  end


  def range_of_data(projects, total)
    min = total.min
    max = total.max

    projects.each do |p|
      max = p[1].max if max < p[1].max
      min = p[1].min if min > p[1].min
    end

    [min, max, ((max - min)/4).to_i]
  end

  def cost_months(project, months)
    subtotal = []
    months.each do |month|
      requested_date = Date.civil(month[0..3].to_i, month[5..6].to_i, 1)
      from = requested_date - 1
      to =  requested_date >> 1
      subtotal << project.project_cost(from, to).to_i
    end
    subtotal
  end

  def profit_months(project, months)
    subtotal = []
    months.each do |month|
      requested_date = Date.civil(month[0..3].to_i, month[5..6].to_i, 1)
      from = requested_date - 1
      to =  requested_date >> 1
      subtotal << project.subtotal_project(from, to).to_i
    end
    subtotal
  end

  def graph_code

    if params[:project_id] == "-1"
      title = Title.new("ALL PROJECTS - PROFIT (last #{params[:count]} months)")
    else
      title = Title.new( Project.find(params[:project_id]).name + " (last #{params[:count]} months)")
    end

    projects, months, range, total_month = last_months(params[:count].to_i, params[:requested_date], params[:project_id])

    line_dot = LineDot.new
    line_dot.width = 4
    line_dot.colour = '#DFC329'
    line_dot.dot_size = 5
    line_dot.values = total_month
    line_dot.text = "TOTAL"

    @line_project = []
    projects.each do |data|
      line = Line.new
      line.width = 1
      line.colour = data[2]
      line.dot_size = 5
      line.values = data[1]
      line.text = data[0]
      @line_project << line
    end
    
    # Added these lines since the previous tutorial
    tmp = []
    x_labels = XAxisLabels.new
    x_labels.set_vertical()

    months.each do |text|
      tmp << XAxisLabel.new(text, '#0000ff', 12, 'diagonal')
    end

    x_labels.labels = tmp

    x = XAxis.new
    x.set_labels(x_labels)
    # new up to here ...

    y = YAxis.new
    y.set_range(range[0], range[1], range[2])

    x_legend = XLegend.new("Months")
    x_legend.set_style('{font-size: 12px; color: #778877}')

    y_legend = YLegend.new("Profit")
    y_legend.set_style('{font-size: 12px; color: #770077}')

    chart = OpenFlashChart.new
    chart.set_title(title)
    chart.set_x_legend(x_legend)
    chart.set_y_legend(y_legend)
    chart.x_axis = x # Added this line since the previous tutorial
    chart.y_axis = y
    

    chart.add_element(line_dot)
    
    @line_project.each do |data|
      chart.add_element data
    end

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

  def dashboard

    @requested_date = Date.civil(params[:requested_date][0..3].to_i, params[:requested_date][5..6].to_i, 1)
    @from_date = @requested_date - 1
    @to_date =  @requested_date >> 1
    @historic_projects = HistoricProject.find(:all, :conditions => ["historic_date > ? and historic_date < ?", @from_date, @to_date])

    @people = Person.all
    @projects = Project.all

    
    if params[:from] and params[:to]

      @project = Project.find(params[:project_id])

      @from = Date.civil(params[:from][0..3].to_i, params[:from][5..6].to_i, 1)
      @to = Date.civil(params[:to][0..3].to_i, params[:to][5..6].to_i, 1)
      
      if @from > @to
        @to = Date.civil(params[:from][0..3].to_i, params[:from][5..6].to_i, 1)
        @from = Date.civil(params[:to][0..3].to_i, params[:to][5..6].to_i, 1)
      end

      count = (months_between(@from,@to) == 0) ? 2 : months_between(@from,@to) + 1
      @graph2 = open_flash_chart_object(600,300,"/person_projects/graph_code/#{@to}/#{count}/#{params[:project_id]}")
      @graph = open_flash_chart_object(600,300,"/person_projects/graph_code/#{@to}/#{count}/-1")
    else
      @project = Project.first
      @graph = open_flash_chart_object(600,300,"/person_projects/graph_code/#{params[:requested_date]}/2/-1")
      @graph2 = open_flash_chart_object(600,300,"/person_projects/graph_code/#{params[:requested_date]}/2/#{@project.id}")
      @from = @requested_date << 1
      @to = @requested_date 
    end

  end

  def months_between( date1=Time.now, date2=Time.now )

    date1 ||= Time.now
    date2 ||= Time.now

    if date1 > date2
      recent_date = date1.to_date

      past_date = date2.to_date
    else
      recent_date = date2.to_date

      past_date = date1.to_date
    end
    years_diff = recent_date.year - past_date.year

    months_diff = recent_date.month - past_date.month
    if months_diff < 0

      months_diff = 12 + months_diff
      years_diff -= 1

    end
    years_diff*12 + months_diff
  end

end