class Survey < ActiveRecord::Base



  def self.get_surveys
    @login = {:username => 'eddiesmith', 
              :apiKey => 'WVJY2K1CP7G2YPE19HWUTHH4IY31PDRF'}
    @api_url = 'https://www.quicktapsurvey.com/api/v2/'
    url = @api_url + 'listSurveys'
    results = RestClient.post url, @login.to_json, {content_type: :json, accept: :json}
    results = JSON.parse(results)
    results['surveyList'].each do |r|
      survey = Survey.new(name: r['surveyName'], api_survey_id: r['surveyId'].to_i)
      store_number = r['surveyName'].match(/^(\d*)/) 
      survey.store = store_number[0].to_i
      if r['surveyName'].match(/Lobby/)
        survey.fc_dt = 'FC'
      end
      if r['surveyName'].match(/Drive/)
        survey.fc_dt = 'FC'
      end
      survey.save
    end
  end

end
