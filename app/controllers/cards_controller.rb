class CardsController < ApplicationController
 # TODO Add before hook?

  def index
    @cards = Card.get_all()
  end
end
