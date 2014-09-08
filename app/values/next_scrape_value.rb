class NextScrapeValue
  def initialize(scrapes_with_no_changes_count)
    @scrapes_with_no_changes_count = scrapes_with_no_changes_count || 0
  end

  def next_scrape_at
    offset = offset_array[@scrapes_with_no_changes_count] || 6.months
    offset.from_now
  end

  private
    def offset_array
      [
        10.minutes,
        20.minutes,
        30.minutes,
        1.hour,
        3.hours,
        6.hours,
        1.day,
        3.days,
        1.week,
        2.weeks,
        1.month,
        3.months,
      ]
    end
end
