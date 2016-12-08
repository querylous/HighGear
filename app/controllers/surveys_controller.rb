class SurveysController < ApplicationController
  def index
    @surveys = Survey.all
  end

  def create
    @survey = Survey.new(survey_params)
  end

  def destroy
    Survey.find(params[:id]).destroy
    redirect_to survey_path
  end

  def new

  end

  def update
    @survey = Survey.find(params[:id])
    @survey.update_attributes!(survey_params)
    if @survey.update(survey_params)
      redirect_to surveys_path, notice: 'Successfully Updated'
    end
  end

  def edit
    @survey = Survey.find(params[:id])
  end

  def show
    @survey = Survey.find(params[:id])
    @responses = Response.where(survey_id: @survey.id).order(created_at: :desc)
  end

  private

  def survey_params
    params.require(:survey).permit(:store, :name, :api_survey_id, 
                                   :api_user, :api_user_key, :fc_dt,
                                   :updateable, :questions)
  end
end
