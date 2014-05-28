require 'rest-client'
require 'json'

puts "Welcome to Reddit!"

puts "Which stories would you like to see? (top, hot)"

feed = gets.strip

puts "Which subreddit would you like to see? (leave blank for none)"

subreddit = gets.strip

if !subreddit.empty?
	subreddit = "r/#{subreddit}/"
end

puts "Loading..."

response = RestClient.get("http://reddit.com/#{subreddit}#{feed}.json")

parsed_response = JSON.parse(response)

stories = parsed_response['data']['children']

stories = stories.sort_by do |story|
	story['data']['score']
end

stories.reverse.first(10).each do |story|
	puts "#{story['data']['score']}: #{story['data']['title']}"
end

