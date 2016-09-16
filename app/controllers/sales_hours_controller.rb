class SalesHoursController < ApplicationController
  def index
    @sales_hours = SalesHour.where(created_at: (Time.now.beginning_of_day + 3.hours)..(Time.now))
  end
end
