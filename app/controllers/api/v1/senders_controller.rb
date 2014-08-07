class Api::V1::SendersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def create
  	
  end
  
end
