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
    "host" => "193.186.253.250",
    "instance" => "00008110-0018345A1E01401E",
          "device" => "iPhone 13-17.0"

  },
    { 
    "host" => "193.186.253.250",
    "instance" => "00008101-000D50DC0CE9003A",
                "device" => "iPhone 12-17.0"
  },
    { 
    "host" => "193.186.253.250",
    "instance" => "00008101-000604AE3463003A",
                "device" => "iPhone 12-17.0"
  },
    { 
    "host" => "193.186.253.250",
    "instance" => "00008101-000A78EE3C04001E",
                "device" => "iPhone 12-17.0"
  },
    { 
    "host" => "193.186.253.250",
    "instance" => "00008101-001E5D2C1A12001E",
      "device" => "iPhone 12-17.0"
  },
    { 
    "host" => "193.186.253.250",
    "instance" => "00008101-000615C114D2001E",
      "device" => "iPhone 12-17.0"
  },
    { 
    "host" => "193.186.253.250",
    "instance" => "00008101-001430811451003A",
      "device" => "iPhone 12-17.0"
  },
    { 
    "host" => "193.186.253.250",
    "instance" => "00008101-000E44A92678001E",
      "device" => "iPhone 12-17.0"
  },



  
    { 
    "host" => "209.208.245.114",
    "instance" => "00008101-000E69940E61001E",
      "device" => "iPhone 12-17.0"
  },
    { 
    "host" => "209.208.245.114",
    "instance" => "00008101-000E31693E43003A",
            "device" => "iPhone 12-17.0"

  },
    { 
    "host" => "209.208.245.114",
    "instance" => "00008101-000544123A05001E",
            "device" => "iPhone 12-17.0"

  },
    { 
    "host" => "209.208.245.114",
    "instance" => "00008101-0004282921A1001E",
            "device" => "iPhone 12-17.0"

  },
    { 
    "host" => "209.208.245.114",
    "instance" => "00008101-000A28123C03001E",
            "device" => "iPhone 12-17.0"

  },



  
    { 
    "host" => "85.209.178.115",
    "instance" => "00008101-00163C1C0A50001E",
                  "device" => "iPhone 12-17.0"
  },
      { 
    "host" => "85.209.178.115",
    "instance" => "00008120-001A79C20C90A01E",
                    "device" => "iPhone 15-17.0"
  },
      { 
    "host" => "85.209.178.115",
    "instance" => "00008120-00092C1C14D2201E",
                    "device" => "iPhone 15-17.0"
  },
      { 
    "host" => "85.209.178.115",
    "instance" => "00008120-000004320E50A01E",
                    "device" => "iPhone 15-17.0"
  },
      { 
    "host" => "85.209.178.115",
    "instance" => "00008120-0009481211D2201E",
                    "device" => "iPhone 15-17.0"
  },
      { 
    "host" => "85.209.178.115",
    "instance" => "00008120-000C242E2100201E",
                    "device" => "iPhone 15-17.0"
  },
      { 
    "host" => "85.209.178.115",
    "instance" => "00008120-000615213438201E",
                    "device" => "iPhone 15 Plus-17.0"
  }
]

# Create a hash for the request data
data = {
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
      data["devices"] = [host["device"]]
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
