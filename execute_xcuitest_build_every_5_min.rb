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
  "sampleApp" => {
    "main" => "bs://9f664a3af2d5240b5dc1076934d33b2e17aa45db",
    "test" => "bs://e868792f81617c1eac71faa58004ad2c16a1bd1a"
  }
}

# Create a hash for the request data
data = {
  "devices" => ["iPhone 12-17 beta", "iPhone 13-17 beta", "iPhone 12 Pro-17 Beta"],
  "project" => "ios 17 5",
  "build" => "github actions",
  "buildTag" => "ios 17 issue reappear",
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
    sleep (60)
  end

  # Sleep for 5 minutes (300 seconds) between runs
  sleep(interval) unless run_number == (num_runs - 1) # Don't sleep after the last run
end
