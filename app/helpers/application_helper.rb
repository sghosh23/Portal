module ApplicationHelper
  def full_title(page_title = '')
    base_title = "kitcarson billing portal"
    if page_title.empty?
      base_title
    else
        "#{page_title} | #{base_title}"
    end
  end

  def label_color(status)
    status = status.to_s
    if status == "Active"
       "label label-primary"
    elsif status == "Overdue"
      "label label-warning"
    elsif status == "Overdue 2"
    return  "label label-warning"
  elsif status == "Overdue 3"
  return  "label label-warning"
    elsif status == "suspended"
      "label label-danger"
    elsif status == "suspended 2"
      "label label-danger"
    end
  end

end
