require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))

    students = []

    html.css(".student-card a").each do |student|
      profile = "#{student.attr('href')}"
      location = student.css(".student-location").text
      name = student.css(".student-name").text

      students << {name: name, location: location, profile_url: profile}
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
