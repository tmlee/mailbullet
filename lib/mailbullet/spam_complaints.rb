module Mailbullet
  module SpamComplaints
    def list_complaints(params)
      api_call "#{params[:domain]}/complaints", params
    end

    def get_complaint(params)
      api_call "#{params[:domain]}/complaints/#{params[:address]}", params
    end

    def add_complaint(params)
      api_call "#{params[:domain]}/complaints", params, :post
    end

    def delete_complaint(params)
      api_call "#{params[:domain]}/complaints/#{params[:address]}", params, :delete
    end

  end
end