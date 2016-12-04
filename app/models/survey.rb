class Survey < ActiveRecord::Base

  has_many :responses

  def self.get_surveys
    @login = {:username => 'eddiesmith', 
              :apiKey => 'WVJY2K1CP7G2YPE19HWUTHH4IY31PDRF'}
    @api_url = 'https://www.quicktapsurvey.com/api/v2/'
    url = @api_url + 'listSurveys'
    results = RestClient.post url, @login.to_json, 
      {content_type: :json, accept: :json}
    results = JSON.parse(results)
    results['surveyList'].each do |r|
      unless Survey.exists?(api_survey_id: r['surveyId'])
        survey = Survey.new(name: r['surveyName'], api_survey_id: r['surveyId'].to_i)
        store_number = r['surveyName'].match(/^(\d*)/) 
        survey.store = store_number[0].to_i
        if r['surveyName'].match(/Lobby/)
          survey.fc_dt = 'FC'
        end
        if r['surveyName'].match(/Drive/)
          survey.fc_dt = 'FC'
        end
        survey.updateable = false
        survey.save
      end
    end
  end
  
  def get_responses(options={})
    @login = {:username => self.api_user,
              :apiKey => self.api_user_key} 
    @api_url = 'https://www.quicktapsurvey.com/api/v2/'
    from_date = (Time.now - 15*60).strftime("%F %T %z") 
    to_date = (Time.now).strftime("%F %T %z") 
    if options[:from_date]
      from_date = Time.parse(options[:from_date]).strftime("%F %T %z")
    end
    if options[:to_date]
      to_date = Time.parse(options[:to_date]).strftime("%F %T %z")
    end
    api_params = { :surveyId => self.api_survey_id, 
               :fromDate => from_date,
               :toDate   => to_date  }

    url = @api_url + 'getSurveyResponses'
    data = @login.merge(api_params)
    results = RestClient.post url, data.to_json, 
      {content_type: :json, accept: :json}
    results = JSON.parse(results)
    if options[:parse]
      
      unless results['responses'].nil?
        results['responses'].each do |r|
          unless Response.exists?(response_id: r['responseId'])
            response = self.responses.build(
                                        created_at: Time.parse(r['dateCollected']), 
                                        response_id: r['responseId'],
                                        store: self.store, 
                                        answers: r['responseValues'].to_json )
            response.save
          end
        end
      end
    end
  end

  def self.get_all_responses(options={})
    Survey.all.each do |s|
      if s.updateable = true
        s.get_responses(from_date: options[:from_date], parse: true)
      end
    end
  end
  
end
