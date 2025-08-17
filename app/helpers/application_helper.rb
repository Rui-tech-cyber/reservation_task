module ApplicationHelper
  def ymd(date)
    date.present? ? l(date, format: :ymd) : "-"
  end

  def ymdhm(dt)
    dt.present? ? l(dt, format: :ymdhm) : "-"
  end
end