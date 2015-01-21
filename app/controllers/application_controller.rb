class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource_or_scope)
    @athlete = Athlete.find_by(user_id: @user.id)
    @trainer = Trainer.find_by(user_id: @user.id)
    if @user.role == 'athlete' && @athlete
      flash[:notice] = "You have been signed in as an athlete!"
      athlete_path(@athlete)
    elsif @user.role == 'trainer' && @trainer
      flash[:notice] = "You have been signed in as an trainer!"
      trainer_path(@trainer)
    end
  end

end
