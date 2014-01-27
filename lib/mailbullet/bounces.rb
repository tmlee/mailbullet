module Mailbullet
  module Bounces
    def list_bounces(params)
      api_call "#{params[:domain]}/bounces", params
    end

    def get_bounce(params)
      api_call "#{params[:domain]}/bounces/#{params[:address]}", params
    end

    def add_bounce(params)
      api_call "#{params[:domain]}/bounces", params, :post
    end

    def delete_bounce(params)
      api_call "#{params[:domain]}/bounces/#{params[:address]}", params, :delete
    end
  end
end