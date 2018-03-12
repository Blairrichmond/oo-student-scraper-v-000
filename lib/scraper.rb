require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))

    student = []

    html.css(".student-card a").each do |student|
      profile = "#{student.attr('href')}"
  end

  def self.scrape_profile_page(profile_url)

  end

end
