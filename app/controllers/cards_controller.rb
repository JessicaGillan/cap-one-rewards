class CardsController < ApplicationController
  def index
    puts session[:access_token]
    options = {}
    
    if(session[:access_token]) 
      # get users rewards cards
      rewards_cards = CapitalOne.get_cards(session[:access_token])["rewardsAccounts"]
      
      puts rewards_cards
      
      # calculate potential rewards & return html list
      options = {
        cards: rewards_cards,
        amount: params[:amount]
      }
    end
      
    @cards = Card.get_reward_options(options)
  end
  
  def test_auth
    # CapitalOne.login()
    
    render layout: false
  end
  
  def login
    puts "CapOne redirect called Login"
    
    auth_code = params['code']
    
    puts "auth code: "
    puts auth_code
    
    response = CapitalOne.get_token(auth_code)
    
    puts "Access token Response: "
    puts response
    
    session[:access_token] = response['access_token']
    
    redirect_to action: 'index', status: 302
  end
end
