require 'net/http'
require 'uri'
require 'json'
require 'base64'

# Define your BrowserStack credentials
username = ARGV[0]
access_key = ARGV[1]
# Set the number of times to run the loop
num_runs = ARGV[2].to_i
# Set the interval duration
interval = ARGV[3].to_i


# Define the API endpoint URL
url = URI.parse('https://api-cloud.browserstack.com/app-automate/xcuitest/v2/build')

# app ids
apps = {
  "sampleapp" => {
    "main" => "bs://87113e935a683dfede59eb317da04d150dca5cad",
    "test" => "bs://45dcedff3cf519be8c90373795465d7b8c15c4b6"
  }
}

devices = ["iPhone 12-17", "iPhone 13-17", "iPhone 15 Pro-17", "iPhone 15 Pro Max-17", "iPhone 15 Plus-17", "iPhone 12 Pro-17"]

# Create a hash for the request data
data = {
  "project" => "ios 17",
  "build" => "github actions",
  "buildTag" => "ios 17 GA - ",
  "networkLogs" => "true",
  "deviceLogs" => "true",
  "enableResultBundle" => "true"
}


# Loop for the specified number of runs
num_runs.times do |run_number|
  puts "Run Number: #{run_number + 1}"

  apps.each do |key, value|
      # Create an HTTP POST request
      request = Net::HTTP::Post.new(url)
      request['Content-Type'] = 'application/json'
  
      data["app"] = value["main"]
      data["testSuite"] = value["test"]
      # host = hosts.sample
      # machine = "#{host["host"]}:#{host["instance"]}"
      # data["machine"] = machine
      data["devices"] = devices
      # data["devices"] = ["iPhone 12 Pro-17"]
      request.body = data.to_json
  
      # Encode the credentials in Base64
      auth_token = Base64.strict_encode64("#{username}:#{access_key}")
  
      # Set the Authorization header
      request['Authorization'] = "Basic #{auth_token}"
  
      # Make the request
      response = Net::HTTP.start(url.host, url.port, use_ssl: true) do |http|
        http.request(request)
      end
  
      # Print the response
      puts "Response Code: #{response.code}"
      puts "Response Body: #{response.body}"
  end
  sleep (500)
  # Sleep for 5 minutes (300 seconds) between runs
  #sleep(interval) unless run_number == (num_runs - 1) # Don't sleep after the last run
end
