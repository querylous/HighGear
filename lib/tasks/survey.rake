namespace :survey do
  desc "Gets surveys from QuickTap API and inserts into DB"
  task get_surveys: :environment do
    puts "#{Time.now.localtime} -- Updating Surveys"
    Survey.get_surveys
    puts "#{Time.now.localtime} -- Updated Surveys"
  end

  desc "Gets responses for each survey from QuickTap API and inserts into DB"
  task get_responses: :environment do
    puts "#{Time.now.localtime} -- Updating Responses..."
    if ENV['from_date'] 
      Survey.get_all_responses(from_date: ENV['from_date'].to_s)
      puts "#{Time.now.localtime} -- Updated Responses starting with #{ENV['from_date']}"
    else
      Survey.get_all_responses
      puts "#{Time.now.localtime} -- Updated Responses"
    end
  end

  desc "Updates responses with the correct user based on Sales hours"
  task update_response_users: :environment do
    puts "#{Time.now.localtime} -- Updating Reponse Users..."
    Response.set_users
    puts "#{Time.now.localtime} -- Updated Reponse Users"
  end

end
