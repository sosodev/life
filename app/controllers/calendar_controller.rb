class CalendarController < ApplicationController
  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @scheduled_tasks = Task.includes(:task_list)
                           .where(scheduled_at: @date.beginning_of_day..@date.end_of_day)
                           .order(:scheduled_at)
  end
end
