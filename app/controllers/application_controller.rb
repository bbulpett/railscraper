class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Define the Headline object
  class Headline
  	def initialize(title, link)
  		@title = title
  		@link = link
  	end
  	attr_reader :title
  	attr_reader :link
  end

  # Pull the site
  def scrape_chinadaily
  	require 'open-uri'
  	doc = Nokogiri::HTML(open("http://www.chinadaily.com.cn/entertainment/celebrities.html"))

  	# Parse for headlines and create array
  	headlines = doc.css('ul.chinanewslst>li')
  	@headlinesArray = []
  	headlines.each do |h|
  		title = h.css('h2.titlebox>a').text
  		link = h.css('h2.titlebox>a')[0]['href']
  		@headlinesArray << Headline.new(title, link)
  	end

  	render template: 'scrape_chinadaily'
  end
end
