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
    profile_page = Nokogiri::HTML(open(profile_url))

    profiles = {}

    link = profile_page.css(".social-icon-container").children.css("a").map { |soc| soc.attribute('href').value}
    link.each do |li|
      if li.include?("linkedin")
        profiles[:linkedin] = link
      elsif li.include?("github")
        profiles[:github] = link
      elsif li.include?("twitter")
        profiles[:twitter] = link
      else
        profiles[:blog] = link
      end
    end

    profiles[:quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote").text

    profiles[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder").text
    if profile_page.css("div.bio-content.content-holder div.description-holder").text

      profiles
  end

end

end
