class VolunteersController < ApplicationController
  helper :all
  before_action :set_volunteer, only: [:show, :edit, :update, :destroy]
  before_action :find_groups, only: [:index]


  # GET /volunteers
  # GET /volunteers.json
  def index
<<<<<<< HEAD
    @all_status = Volunteer.all_status
    @selected_status = params[:status] || session[:status] || {}
    
    @all_states = Volunteer.all_states
    @selected_state = params[:state] || session[:state] || {}
    
    @all_education = Volunteer.all_education
    @selected_education = params[:education] || session[:education] || {}
    
    @selected_major = params[:major] || session[:major] || {}

    
    ungrouped = Volunteer.where(group: "Unassigned")
    
    @volunteers = ungrouped
    if @selected_status != "Select"
      @volunteers = @volunteers.where(status: @selected_status)
=======
    if logged_in?
    
      @all_status = Volunteer.all_status
      @selected_status = params[:status] || session[:status] || {}
      
      @all_states = Volunteer.all_states
      @selected_states = params[:state] || session[:state] || {}
      
      # if @selected_status == "Select One"
      #   @volunteers = Volunteer.all
      #   # @selected_status = Hash[@all_status.map {|rating| [rating, rating]}]
      # else
      #   @volunteers = Volunteer.where(status: @selected_status)
      # end
      
      # if @selected_states == "Select One"
      # if @selected_status == "Select One" || @selected_states == "Select One"
      #   @volunteers = Volunteer.all
      # else
      if @selected_status == "Select_One" && @selected_states == "Select_One"
        @volunteers = Volunteer.all
      elsif @selected_states == "Select_One"
        @volunteers = Volunteer.where(status: @selected_status)
      elsif @selected_status == "Select_One"
        @volunteers = Volunteer.where(state: @selected_states)
      else
        @volunteers = Volunteer.where(status: @selected_status, state: @selected_states)
      end
    else
      redirect_to login_path
>>>>>>> e154c7554f795ea33f3a5de6fe7dfe4fec04fb72
    end
    
    if @selected_state != "Select"
      @volunteers = @volunteers.where(state: @selected_state)
    end
    
    if @selected_education != "Select"
      @volunteers = @volunteers.where(education: @selected_education)
    end
    if @selected_major != nil
      @volunteers = @volunteers.where("major like ?", @selected_major)
      
    end
    
      

  end


  # GET /volunteers/1
  # GET /volunteers/1.json
  def show
  end

  # GET /volunteers/new
  def new
    @groups = Volunteer.groups
    @volunteer = Volunteer.new
    @states = Volunteer.all_states
    @statuses = Volunteer.status_volunteer
    @education = Volunteer.education_volunteer
    @time_invest = Volunteer.time_invest_volunteer
    @places = Volunteer.all_places
    @involvement = Volunteer.involvement
  end

  # GET /volunteers/1/edit
  def edit

    @groups = Volunteer.groups
    @states = Volunteer.all_states
    @statuses = Volunteer.status_volunteer
    @education = Volunteer.education_volunteer
    @time_invest = Volunteer.time_invest_volunteer
    @places = Volunteer.all_places
    @involvement = Volunteer.involvement
  end

  # POST /volunteers
  # POST /volunteers.json
  def create
    # if @volunteer..nil? || @movie.director.empty?
    #   flash[:notice] = "'#{@movie.title}' has no director info"
    #   redirect_to movies_path
    # else
    #   @movies = Movie.search_director(params[:id])
    # end
    @volunteer = Volunteer.new(volunteer_params)
    if @volunteer.first_name.empty?
      flash[:notice] = "Error: Invalid first name."
      redirect_to new_volunteer_path
    elsif @volunteer.last_name.empty?
      flash[:notice] = "Error: Invalid last name."
      redirect_to new_volunteer_path
    elsif @volunteer.phone.empty? or ((@volunteer.phone =~ /^([0-9]{3}(\s|\-)?){2}[0-9]{4}$/) != 0)
      flash[:notice] = "Error: Invalid phone number."
      redirect_to new_volunteer_path
    elsif @volunteer.email.empty? or ((@volunteer.email.upcase =~ /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/) != 0)
      flash[:notice] = "Error: Invalid email address."
      redirect_to new_volunteer_path
    elsif @volunteer.city.empty? 
      flash[:notice] = "Error: Invalid City."
      redirect_to new_volunteer_path
    else
      respond_to do |format|
        if @volunteer.save
          format.html { redirect_to @volunteer, notice: 'Volunteer was successfully created.' }
          format.json { render :show, status: :created, location: @volunteer }
        else
          format.html { render :new }
          format.json { render json: @volunteer.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /volunteers/1
  # PATCH/PUT /volunteers/1.json
  def update
    respond_to do |format|
      if @volunteer.update(volunteer_params)
        format.html { redirect_to @volunteer, notice: 'Volunteer was successfully updated.' }
        format.json { render :show, status: :ok, location: @volunteer }
      else
        format.html { render :edit }
        format.json { render json: @volunteer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /volunteers/1
  # DELETE /volunteers/1.json
  def destroy
    @volunteer.destroy
    respond_to do |format|
      format.html { redirect_to volunteers_url, notice: 'Volunteer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  

  
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_volunteer
      @volunteer = Volunteer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def volunteer_params
      params.require(:volunteer).permit(:first_name, :last_name, :phone, :email, :city, :state, :subscribe, 
      :join_team, :status, :education, :major, :certification, :languages, :fluency, :ewb_experience, :international_experience, :work_experience, :reason, :time_investment,
      :travel, :places, :current_events, :involvement, :group)
    end
    
    def find_groups
      @grouped = Hash.new()
      Volunteer.groups.each do |group|
        @grouped[group] = Volunteer.where(group: group)
      end
      @grouped
    end
end


    
