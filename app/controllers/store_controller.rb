class StoreController < ApplicationController
  include CurrentCart
  before_action :set_visits, :set_cart

  def index
    @products = Product.order(:title)
  end

private

  def set_visits
    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end

    @visit = session[:counter]
  end
end
