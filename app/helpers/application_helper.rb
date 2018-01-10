module ApplicationHelper

  def render_datetime(time, format=nil)
    return unless time
    if format
      time.strftime(format)
    else
      time.strftime("%d/%m/%Y at %I:%M %p")
    end
  end
end
