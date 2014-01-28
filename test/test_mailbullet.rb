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

  ## Bounces

  def test_list_bounces
    stub_get("https://api:xxx@api.mailgun.net/v2/domain.com/bounces?domain=domain.com", "bounces/list_bounces.json")
    result = Mailbullet::Client.secret_client.list_bounces domain: "domain.com"
    assert_equal result["total_count"], 1
    assert_not_equal result["items"].size, 0
  end

  def test_get_bounce
    stub_get("https://api:xxx@api.mailgun.net/v2/domain.com/bounces/test@example.com?domain=domain.com&address=test%40example.com", "bounces/get_bounce.json")
    result = Mailbullet::Client.secret_client.get_bounce domain: "domain.com", address: "test@example.com"
    assert_equal result["bounce"]["address"], "test@example.com"
  end

  def test_add_bounce
    stub_post("https://api:xxx@api.mailgun.net/v2/domain.com/bounces", "bounces/add_bounce.json")
    result = Mailbullet::Client.secret_client.add_bounce domain: "domain.com", address: "test@example.com", code: 550, reason: 'anything'
    assert_equal result["message"], "Address has been added to the bounces table"
  end

  def test_delete_bounce
    stub_delete("https://api:xxx@api.mailgun.net/v2/domain.com/bounces/test@example.com", "bounces/delete_bounce.json")
    result = Mailbullet::Client.secret_client.delete_bounce domain: "domain.com", address: "test@example.com"
    assert_equal result["message"], "Bounced address has been removed"
  end

  ## Spam Complaints

  def test_list_complaints
    stub_get("https://api:xxx@api.mailgun.net/v2/domain.com/complaints?domain=domain.com", "spam_complaints/list_complaints.json")
    result = Mailbullet::Client.secret_client.list_complaints domain: "domain.com"
    assert_equal result["total_count"], 1
    assert_not_equal result["items"].size, 0
  end

  def test_get_complaint
    stub_get("https://api:xxx@api.mailgun.net/v2/domain.com/complaints/test@example.com?domain=domain.com&address=test%40example.com", "spam_complaints/get_complaint.json")
    result = Mailbullet::Client.secret_client.get_complaint domain: "domain.com", address: "test@example.com"
    assert_equal result["complaint"]["address"], "test@example.com"
  end

  def test_add_complaint
    stub_post("https://api:xxx@api.mailgun.net/v2/domain.com/complaints", "spam_complaints/add_complaint.json")
    result = Mailbullet::Client.secret_client.add_complaint domain: "domain.com", address: "test@example.com"
    assert_equal result["message"], "Address has been added to the complaints table"
  end

  def test_delete_complaint
    stub_delete("https://api:xxx@api.mailgun.net/v2/domain.com/complaints/test@example.com", "spam_complaints/delete_complaint.json")
    result = Mailbullet::Client.secret_client.delete_complaint domain: "domain.com", address: "test@example.com"
    assert_equal result["message"], "Spam complaint has been removed"
  end


end