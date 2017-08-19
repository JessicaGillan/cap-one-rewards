class CapitalOne

# Constant URL section
BASE_URL = 'https://api.devexhacks.com/'

CLIENT_ID = 'vgw3sf4f8nq3b98i1gdfr8wpx4gpty0ska52'

CLIENT_SECRET = 'eb5f6rda6v0d1ld8y4fymkudo86gorrc47cj'

# REDIRECT_URI = 'https://rewardsranker.herokuapp.com/login'
REDIRECT_URI = 'https://rewardsranker.herokuapp.com/login'

# Public: Make the HTTP call to TMDB to grab the most poopular movies
#
# options - Hash: http options hash for url query params
#
def self.get_cards(access_token)
  response = HTTParty.get(build_url('rewards/accounts', options), headers: get_headers(access_token), debug_output: $stdout)
  JSON.parse(response.body)
end

def self.get_card_details(access_token, id)
  response = HTTParty.get(build_url("rewards/accounts/#{id}", options), headers: get_headers(access_token), debug_output: $stdout)
  JSON.parse(response.body)
end

# https://api.devexhacks.com/oauth2/authorize?
def self.login
  options = {
    redirect_uri: REDIRECT_URI,
    scope: 'read_rewards_account_info',
    client_id: CLIENT_ID,
    response_type: 'code'
  }
  
  HTTParty.get(build_url("oauth2/authorize", options), headers: get_headers(), debug_output: $stdout)
end

# curl -i -k --tlsv1 -H "Content-Type:application/x-www-form-urlencoded" 
# -d “code={3e07a3951b1a4df69bc7b8469146f473}
# &client_id= vgw3sf4f8nq3b98i1gdfr8wpx4gpty0ska52
# &client_secret= eb5f6rda6v0d1ld8y4fymkudo86gorrc47cj
# &grant_type=authorization_code
# &redirect_uri={https://developer.capitalone.com/products/playground}" 
# -X POST https://api.devexhacks.com/oauth2/token
def self.get_token(auth_code)
  response = HTTParty.post(
    build_url('oauth2/token', {}), 
    :body => { :code => auth_code, 
               :client_id => CLIENT_ID, 
               :client_secret => CLIENT_SECRET, 
               :grant_type => 'authorization_code', 
               :redirect_uri => REDIRECT_URI
             }.to_json,
    headers: get_headers(), 
    debug_output: $stdout)
    
  JSON.parse(response.body)
end

private

  # Private: combine the three sections of the API url
  #
  # product - String: Movie or Tv Show
  # options - Hash: url query params hash
  #
  def self.build_url(product, options = nil)
    "#{BASE_URL}#{product}#{build_query_string(options)}"
  end

  # Private: convert hash of query params to string
  #
  # options - Hash: Hash of query parameters
  #
  def self.build_query_string(options)

    q_str = ""
    return q_str if !options || options.empty?
    
    q_str = "?"
    
    options.each do |key, value|
      q_str += "&#{key}=#{value}"
    end

    q_str
  end
  
  def self.get_headers(access_token = nil)
    # HTTP Headers to be added
    if(access_token)
      {"Authorization" => "Bearer #{access_token}", "Content-Type": "application/json;charset=utf-8" }
    else
      {"Content-Type": "application/x-www-form-urlencoded" }
    end
  end

end