class Api::V1::SendersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def create
  	respond_to do |format|
  		if data = valid_email?(checked_params)
  			EmailSender.notify(data).deliver
  			format.json { render json: {success: true} }
  		else
  			format.json { render json: {success: false} }
  		end
  	end
  end

  private

  def checked_params
  	params.require(:sender).permit :to, :subject, :body
  end

  def valid_email?(data)
  	email_regex = /<(([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+)>/
  	to = data[:to]
  	if to && m = to.match(email_regex)
  		data[:email] = m[1]
      return data
  	else
  		return false
  	end
  end
end
