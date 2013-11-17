module Mailbullet
  module Messages
    def send_message(params)
      api_call "#{params[:domain]}/messages", params, :post
    end

    def send_mime_message(params)
      api_call "#{params[:domain]}/messages.mime", params, :post
    end

    def retrieve_stored_message(params)
      api_call "domains/params[:domain]/messages", params
    end

    def delete_stored_message(params)
      api_call "domains/params[:domain]/messages/params[:message]", params
    end
  end
end