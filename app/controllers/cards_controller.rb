class CardsController < ApplicationController
 # TODO Add before hook?

  def index
    # @cards
  end

  def show
    @card = card.find_by_id(params[:id])
  end

  def new
    @card = card.new
  end

  def create
    @card = card.new(card_params)

    if @card.save
      flash[:success] = "card Saved"
      redirect_to @card
    else
      flash.now[:error] = "Error: " + @card.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
    @card = card.find_by_id(params[:id])
  end

  def update
    @card = card.find_by_id(params[:id])

    if @card.update( card_params )
      flash[:success] = "card Edited"
      redirect_to ( @card.completed ? root_path : @card )
    else
      flash.now[:error] = "Error: " + @card.errors.full_messages.join(', ')
      render :new
    end
  end

  def destroy
    @card = card.find_by_id(params[:id])

    if @card
      @card.delete
      flash[:success] = "card Deleted"
      redirect_to root_path
    else
      flash.now[:error] = "Error: " + @card.errors.full_messages.join(', ')
      render :index
    end
  end


  private

  def card_params
    params.require(:card).permit(:description, :completion_date, :completed, :priority)
  end

  def sorted_cards
    card.all.sort_by { |card| card.completion_date }
  end

end
