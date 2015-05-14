class RegisteredApplicationsController < ApplicationController
  def index
    @user = current_user
    @registered_applications = RegisteredApplication.where('user_id = ?', @user.id)
  end
  
  def new
    @registered_application = RegisteredApplication.new
  end
  
  def create
    @user = current_user
    @registered_application = @user.registered_applications.build(app_params)
    
    if @registered_application.save
      flash[:notice] = "App Saved"
      redirect_to registered_applications_path
    else
      flash[:error] = "There was a problem saving your app"
      render :new
    end
    
  end
  
  def show
    @registered_application = RegisteredApplication.find(params[:id])
    @events = @registered_application.events
    @events_name = []
    
    @events.each do |event|
      unless @events_name.include?(event.name)
        @events_name << event.name
      end
    end
    
    @events_grouped = @registered_application.events.group_by(&:name)
  end
  
  def read
    @registered_application = RegisteredApplication.find(params[:id])
  end
  
  def destroy
    @registered_application = RegisteredApplication.find(params[:id])
    
    if @registered_application.destroy
      flash[:notice] = "App Deleted"
      redirect_to registered_applications_path
    else
      flash[:error] = "There was a problem deleting your app"
      redirect_to registered_applications_path
    end
  end
  
  private
  
  def app_params
    params.require(:registered_application).permit(:name, :url)
  end
  
end
