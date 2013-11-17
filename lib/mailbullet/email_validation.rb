module Mailbullet
  module EmailValidation
    def address_validate(params)
      api_call "address/validate", params
    end
  end
end