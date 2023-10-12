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
  "aws" => {
    "main" => "bs://04bafa2024578513db6b4cb2cb344acf7bfe9005",
    "test" => "bs://e6812b00a0a7205d9016161bcc208a4e47472b53"
  },
  "sampleapp" => {
    "main" => "bs://36c5689263786de157ba0d5057000fc78be5ea0a",
    "test" => "bs://a2386bf878a4f63d8e591e110716254a7346fb31"
  },
  "budgetkeeper" => {
    "main" => "bs://e36cfabf495f7b4a4c6aff8a80b3a2795c42521c",
    "test" => "bs://91d13dc6c50e2387b72793ee5293d5643a5ac19d"
  }
}

hosts = [
  { 
    "host" => "203.32.41.137",
    "instance" => "00008120-001179CC0158201E"
  },
    { 
    "host" => "203.32.41.137",
    "instance" => "00008120-00090DC83EB8201E"
  },
    { 
    "host" => "203.32.41.137",
    "instance" => "00008120-000E49DC2E38201E"
  },
    { 
    "host" => "203.32.41.137",
    "instance" => "00008120-000471460E00201E"
  },
    { 
    "host" => "203.32.41.137",
    "instance" => "00008120-001234943A04201E"
  },
    { 
    "host" => "203.32.41.137",
    "instance" => "00008120-00144D021138201E"
  },
    { 
    "host" => "203.32.41.137",
    "instance" => "00008120-000605021138201E"
  },
    { 
    "host" => "203.32.41.137",
    "instance" => "00008120-001179CC0158201E"
  },
    { 
    "host" => "203.32.41.138",
    "instance" => "00008120-000E758A1A62201E"
  },
    { 
    "host" => "203.32.41.138",
    "instance" => "00008120-000C604E3A32201E"
  },
    { 
    "host" => "203.32.41.138",
    "instance" => "00008120-001A79CC0C80201E"
  },
    { 
    "host" => "203.32.41.138",
    "instance" => "00008120-000A51AC3A92201E"
  },
    { 
    "host" => "203.32.41.138",
    "instance" => "00008120-001C483E2200201E"
  },
    { 
    "host" => "203.32.41.138",
    "instance" => "00008120-000278C41192201E"
  }
]

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
      # Create an HTTP POST request
      request = Net::HTTP::Post.new(url)
      request['Content-Type'] = 'application/json'
  
      data["app"] = value["main"]
      data["testSuite"] = value["test"]
      host = hosts.sample
      machine = "#{host["host"]}:#{host["instance"]}"
      data["machine"] = machine
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
      sleep (300)
  end

  # Sleep for 5 minutes (300 seconds) between runs
  #sleep(interval) unless run_number == (num_runs - 1) # Don't sleep after the last run
end
