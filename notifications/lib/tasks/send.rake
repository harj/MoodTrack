desc "Send push notifications to remind users to track mood"
task :send => [:environment] do

  url = "https://api.parse.com/1/push"
  headers = {
    "X-Parse-Application-Id"=>"pNRcpH7eSXGzWGXhejabGFeyJEAhcdBLSe0Ft7XH", 
    "X-Parse-REST-API-Key"=>"2WglIorOkjm5zArRFwC8YCYkuNvClQscD0YuPcu9", 
    "Content-Type"=>"application/json", 
    "X-Requested-With"=>"XMLHttpRequest"
  } 
  params = { 
    "channel" => "", 
    "data" => { "alert" => "How are you feeling?" }
  }

  RestClient.post(url, params.to_json, headers)

end
  

