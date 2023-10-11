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
  "budgetKeeper" => {
    "main" => "bs://e36cfabf495f7b4a4c6aff8a80b3a2795c42521c",
    "test" => "bs://91d13dc6c50e2387b72793ee5293d5643a5ac19d"
  }
}

hosts = ["203.32.41.137", "203.32.41.138"]

# Create a hash for the request data
data = {
  "devices" => ["iPhone 15-17.0"],
  "project" => "ios 17",
  "build" => "github actions",
  "buildTag" => "ios 17 workaround",
  "networkLogs" => "true",
  "deviceLogs" => "true",
  "enableResultBundle" => "true"
}


# Loop for the specified number of runs
num_runs.times do |run_number|
  puts "Run Number: #{run_number + 1}"

  apps.each do |key, value|
    hosts.each do |host|
      # Create an HTTP POST request
      request = Net::HTTP::Post.new(url)
      request['Content-Type'] = 'application/json'
  
      data["app"] = value["main"]
      data["testSuite"] = value["test"]
      data["machine"] = host
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
      sleep (2)
    end
  end

  # Sleep for 5 minutes (300 seconds) between runs
  sleep(interval) unless run_number == (num_runs - 1) # Don't sleep after the last run
end
