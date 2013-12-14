require 'test/unit'
require 'test_helper'
require 'mailbullet'

class MailbulletTest < Test::Unit::TestCase

  PUBLIC_KEY = 'xxx'
  SECRET_KEY = 'xxx'

  def setup
    Mailbullet::Client.public_client = Mailbullet::Client.new(public: PUBLIC_KEY)
    Mailbullet::Client.secret_client = Mailbullet::Client.new(secret: SECRET_KEY)
  end

  ## Email Validation

  def test_address_validate
    stub_get("https://api:xxx@api.mailgun.net/v2/address/validate?address=hello%40yahoo.com", "email_validation/address_validate.json")
    result = Mailbullet::Client.public_client.address_validate(address: "hello@yahoo.com")
    assert result["is_valid"]
  end

  ## Messages

  def test_send_message
    stub_post("https://api:xxx@api.mailgun.net/v2/domain.com/messages", "messages/send_message.json")
    result = Mailbullet::Client.secret_client.send_message(domain: "domain.com", from: "Excited user", to: "someone@email.com", subject: "hello", text: "mailgun test")
    assert_equal result["message"], "Queued. Thank you."
  end


end