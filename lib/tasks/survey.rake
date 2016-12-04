namespace :survey do
  desc "Gets surveys from QuickTap API and inserts into DB"
  task get_surveys: :environment do
    Survey.get_surveys
    puts "#{Time.now.localtime} -- Updated Surveys"
  end

  desc "Gets responses for each survey from QuickTap API and inserts into DB"
  task get_responses: :environment do
    Survey.get_all_responses
    puts "#{Time.now.localtime} -- Updated Responses"
  end

  desc "Updates responses with the correct user based on Sales hours"
  task update_response_users: :environment do
    Response.set_users
    puts "#{Time.now.localtime} -- Updated Reponse Users"
  end

end
