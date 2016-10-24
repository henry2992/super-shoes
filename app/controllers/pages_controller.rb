class PagesController < ApplicationController
  
  def home
  	
  	@stores = Store.all

  end


end
