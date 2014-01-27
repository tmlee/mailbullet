# Mailbullet

  Ruby wrapper for Mailgun (www.mailgun.com) Web API which can be found at http://documentation.mailgun.com/api_reference.html

## Installation

Add this line to your application's Gemfile:

    gem 'mailbullet'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mailbullet

## Usage

Initialize a secret and/or public Mailbullet Client to start querying Mailgun APIs

    Mailbullet::Client.public_client = Mailbullet::Client.new(public: 'pubkey-...')
    Mailbullet::Client.secret_client = Mailbullet::Client.new(secret: 'key-...')

Email Validation

    Mailbullet::Client.public_client.address_validate(address: "hello@yahoo.com")

Messaging

    Mailbullet::Client.secret_client.send_message(domain: "domain.com", from: "Excited user", to: "someone@email.com", subject: "hello", text: "mailgun test")

Bounces

    Mailbullet::Client.secret_client.list_bounces domain: "domain.com"
    Mailbullet::Client.secret_client.get_bounce domain: "domain.com", address: "test@example.com"
    Mailbullet::Client.secret_client.add_bounce domain: "domain.com", address: "test@example.com", code: 550, reason: 'anything'
    Mailbullet::Client.secret_client.delete_bounce domain: "domain.com", address: "test@example.com"

## Contributing

More APIs coming its way... Can't find the API you are looking for? Would you like to contribute?

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request