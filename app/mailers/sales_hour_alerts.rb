class SalesHourAlerts < ApplicationMailer
  default from: 'tech@mcdbeau.me'

  def sales_hour_alerts(user, time)
    @user = user
    @time = time
    mail(to: @user.email, subject: 'Warning - Managers not tracking.')
  end
end
