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
    "host" => "209.10.139.177",
    "instance" => "00008101-0001104A3632001E",
          "device" => "iPhone 12 Pro-17.0"

  },
    { 
    "host" => "209.10.139.177",
    "instance" => "00008101-00125D423482001E",
                "device" => "iPhone 12 Pro-17.0"
  },
    { 
    "host" => "209.10.139.177",
    "instance" => "00008030-000D18362652802E",
                "device" => "iPhone 11 Pro-17.0"
  },
    { 
    "host" => "209.10.139.177",
    "instance" => "00008101-000515893AE9003A",
      "device" => "iPhone 12 Pro-17.0"
  },
    { 
    "host" => "209.10.139.177",
    "instance" => "00008030-0014744902E9802E",
      "device" => "iPhone 11 Pro-17.0"
  },
    { 
    "host" => "209.10.139.177",
    "instance" => "00008030-001578511A6A802E",
      "device" => "iPhone 11 Pro-17.0"
  },
    { 
    "host" => "209.10.139.177",
    "instance" => "00008120-0011342611A2201E",
      "device" => "iPhone 15-17.0"
  },



  
    { 
    "host" => "65.74.165.177",
    "instance" => "00008110-0016456C2ED1801E",
      "device" => "	iPhone 13-17.0"
  },
    { 
    "host" => "65.74.165.177",
    "instance" => "00008120-000858EA2110A01E",
            "device" => "iPhone 15-17.0"

  },
    { 
    "host" => "65.74.165.177",
    "instance" => "00008120-0016156022D2201E",
            "device" => "iPhone 15-17.0"

  },
    { 
    "host" => "65.74.165.177",
    "instance" => "00008120-00161D611AE0A01E",
            "device" => "iPhone 15-17.0"

  },
      { 
    "host" => "65.74.165.177",
    "instance" => "00008120-00021CA11AE0A01E",
            "device" => "iPhone 15-17.0"

  },
      { 
    "host" => "65.74.165.177",
    "instance" => "00008120-0010590E0A90A01E",
            "device" => "iPhone 15-17.0"

  },
      { 
    "host" => "65.74.165.177",
    "instance" => "00008120-001A05EC3610A01E",
            "device" => "iPhone 15-17.0"

  },
      



  
    { 
    "host" => "194.165.163.62",
    "instance" => "00008110-0011550434F1801E",
                  "device" => "iPhone 13-17.0"
  },
      { 
    "host" => "194.165.163.62",
    "instance" => "00008120-000429D93A12201E",
                    "device" => "iPhone 15-17.0"
  },
      { 
    "host" => "194.165.163.62",
    "instance" => "00008120-001E3D6A1E12201E",
                    "device" => "iPhone 15-17.0"
  },
      { 
    "host" => "194.165.163.62",
    "instance" => "00008120-000158210E32201E",
                    "device" => "iPhone 15-17.0"
  },
      { 
    "host" => "194.165.163.62",
    "instance" => "00008120-000E796802E0A01E",
                    "device" => "iPhone 15-17.0"
  },
      { 
    "host" => "194.165.163.62",
    "instance" => "00008120-001A15A43A52201E",
                    "device" => "iPhone 15-17.0"
  },


        { 
    "host" => "85.209.178.26",
    "instance" => "00008101-0004756A11C0001E",
                    "device" => "iPhone 12-17.0"
  },
      { 
    "host" => "85.209.178.26",
    "instance" => "00008101-0009585034BA001E",
                    "device" => "iPhone 12 Pro-17.0"
  },
      { 
    "host" => "85.209.178.26",
    "instance" => "00008101-001A118414BA001E",
                    "device" => "iPhone 12 Pro-17.0"
  },
      { 
    "host" => "85.209.178.26",
    "instance" => "00008101-000C692A1141001E",
                    "device" => "iPhone 12 Pro-17.0"
  },




          { 
    "host" => "185.255.127.53",
    "instance" => "00008110-001C24A03C9A401E",
                    "device" => "iPhone 13-17.0"
  },
      { 
    "host" => "185.255.127.53",
    "instance" => "00008120-001215183CD0A01E",
                    "device" => "iPhone 15-17.0"
  },
      { 
    "host" => "185.255.127.53",
    "instance" => "00008120-00064CEA0A32201E",
                    "device" => "iPhone 15-17.0"
  },
      { 
    "host" => "185.255.127.53",
    "instance" => "00008120-001C49E41EF8201E",
                    "device" => "iPhone 15-17.0"
  },
          { 
    "host" => "185.255.127.53",
    "instance" => "00008120-000E29A23622201E",
                    "device" => "iPhone 15-17.0"
  },
      { 
    "host" => "185.255.127.53",
    "instance" => "00008120-00186DAA1AE2201E",
                    "device" => "iPhone 15-17.0"
  },
      { 
    "host" => "185.255.127.53",
    "instance" => "00008120-001C496E1AD8201E",
                    "device" => "iPhone 15-17.0"
  },
      { 
    "host" => "185.255.127.53",
    "instance" => "00008120-001E0D510C87C01E",
                    "device" => "iPhone 15-17.0"
  },






  
            { 
    "host" => "102.165.49.114",
    "instance" => "00008030-001274882128802E",
                    "device" => "iPhone 11 Pro-17.0"
  },
      { 
    "host" => "102.165.49.114",
    "instance" => "00008130-001819C11A20001C",
                    "device" => "iPhone 15 Pro-17.0"
  },
      { 
    "host" => "102.165.49.114",
    "instance" => "00008120-001410360252201E",
                    "device" => "iPhone 15-17.0"
  },
      { 
    "host" => "102.165.49.114",
    "instance" => "00008120-00011CDA3A87C01E",
                    "device" => "iPhone 15-17.0"
  },
          { 
    "host" => "102.165.49.114",
    "instance" => "00008120-001C48E80C98201E",
                    "device" => "iPhone 15-17.0"
  },
      { 
    "host" => "102.165.49.114",
    "instance" => "00008120-001E28341102201E",
                    "device" => "iPhone 15-17.0"
  },
      { 
    "host" => "102.165.49.114",
    "instance" => "00008120-000C09480C92201E",
                    "device" => "iPhone 15-17.0"
  },
      { 
    "host" => "102.165.49.114",
    "instance" => "00008120-001A30200232201E",
                    "device" => "iPhone 15-17.0"
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
