class Card
  
  PRODUCTS = {
    "Capital One Venture": {
      "productId": "SB063c48a7bf814c0badde9a96f92ae73f",
      "productDisplayName": "Capital One® Venture® Rewards Credit Card",
      "applyNowLink": "https://goto.capitalone.com/c/mpid/344893/5048?prodsku=SB063c48a7bf814c0badde9a96f92ae73f&p.prodline=USCIR&p.lid=L&u=https%3A%2F%2Fwww.capitalone.com%2Fcredit-cards%2Fventure",
      "productType": "ConsumerCard",
      "brandName": "Venture",
      "rewards": [
        {
          "rewardsTiers": [
            {
              "tier": 1,
              "value": 2,
              "type": "Miles",
              "terms": "per dollar on every purchase, every day"
            }
          ],
          "rewardsBonus": {
            "rewardsBonusValue": 40000,
            "rewardsBonusType": "Miles",
            "rewardsBonusTerms": "once you spend $3,000 on purchases within 3 months from account opening"
          }
        }
      ]
    },
    "Capital One VentureOne": {
      "productId": "SB2dd21f6823b44777b085cec8f104b93f",
      "productDisplayName": "Capital One® VentureOne® Rewards Credit Card",
      "applyNowLink": "https://goto.capitalone.com/c/mpid/344893/5048?prodsku=SB2dd21f6823b44777b085cec8f104b93f&p.prodline=USCIR&p.lid=L&u=https%3A%2F%2Fwww.capitalone.com%2Fcredit-cards%2Fventureone",
      "productType": "ConsumerCard",
      "brandName": "VentureOne",
      "rewards": [
        {
          "rewardsTiers": [
            {
              "tier": 1,
              "value": 1.25,
              "type": "Miles",
              "terms": "per dollar on every purchase, every day"
            }
          ],
          "rewardsBonus": {
            "rewardsBonusValue": 20000,
            "rewardsBonusType": "Miles",
            "rewardsBonusTerms": "once you spend $1,000 on purchases within 3 months from account opening"
          }
        }
      ]
    }
  }
  
  REWARDS_CARDS = [
    {
      "rewardsAccountReferenceId":"a3774c0661b46be503d62",
      "accountDisplayName":"Capital One Mastercard Worldcard Cash *4734",
      "rewardsCurrency":"Cash","productAccountType":"Credit Card",
      "creditCardAccount":
      {
        "issuer":"Capital One",
        "product":"Venture",
        "network":"MasterCard",
        "lastFour":"4734",
        "isBusinessAccount":false
      }
    },
    {
      "rewardsAccountReferenceId":"a3774c0661b46be503d62",
      "accountDisplayName":"Capital One Mastercard Worldcard Cash *4734",
      "rewardsCurrency":"Cash","productAccountType":"Credit Card",
      "creditCardAccount":
      {
        "issuer":"Capital One",
        "product":"VentureOne",
        "network":"MasterCard",
        "lastFour":"4734",
        "isBusinessAccount":false
      }
    }
  ]

  
  # "creditCardAccount" -> {"issuer":"Capital One" + "product":"Mastercard Worldcard",
  # [
  #   {
  #     name: "Capital One Venture Card",
  #     earnings: "300 miles",
  #     cash_value: "$150.00"
  #   },
  #   {
  #     name: "Capital One Cash Card",
  #     earnings: "300 dollars",
  #     cash_value: "$100.00"
  #   }
  # ]
  def self.get_reward_options(options)
    cards = options['cards'] || REWARDS_CARDS
    amount = options['amount'] || 96.73
    reward_options = []
    
    cards.each do |card|
      name = card[:creditCardAccount][:issuer] + " " + card[:creditCardAccount][:product]
      
      if(PRODUCTS[name.to_sym]) then             
        reward_options.push({
          name: name,
          earnings: (PRODUCTS[name.to_sym][:rewards][0][:rewardsTiers][0][:value] * amount).round(2),
          cash_value: ""
        })
      end
    end
    
    sorted = reward_options.sort { |a, b| b[:earnings] <=> a[:earnings] }
    
    sorted
  end
end