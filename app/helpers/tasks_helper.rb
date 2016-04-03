module TasksHelper
  def task_status(t)
    key = Task::TASK_STATUS.index(t.status)
    "<span class='label label-#{Task::TASK_STATUS_COLOR_CODES[key]}'>#{t.status}</span>".html_safe
  end
end
