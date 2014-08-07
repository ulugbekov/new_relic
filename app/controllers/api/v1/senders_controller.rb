class Api::V1::SendersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def create
  	respond_to do |format|
  		if valid_email?(checked_params)
  			
  			format.json { render json: {success: true} }
  		else
  			format.json { render json: {success: false} }
  		end
  	end
  end

  private

  def checked_params
  	params.permit :to, :sender, :body
  end

  def valid_email?(data)
  	email_regex = /<(([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+)>/
  	to = data[:to]
  	if to && m = to.match(email_regex)
  		data[:email] = m[1]
  		return true
  	else
  		return false
  	end
  end
end
