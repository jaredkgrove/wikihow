# Wikihow

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/wikihow`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wikihow'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wikihow

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/'immutable-founder-5073'/wikihow. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Wikihow project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/'immutable-founder-5073'/wikihow/blob/master/CODE_OF_CONDUCT.md).

## Project Notes

What website will you be scraping? wikihow.com
What will you need to do with the data you return from scraping? create category instances (should I create topic classes right away or after user selection?)
What classes will you be using? Scraper class (separate scraper classes for main page, category page, and topic page?), cli class, category class, topic class
What will be the flow of displaying data for your application. ex How will your CLI portion work. Ask user to select a category. Scrape category page for how-to topics, ask user to select topic. Scrape topic page for methods. Ask user to select method. Show Method steps to user.
How will you display data one level deep to the user?
What will need to be in your README file? An explanation of how to use the program?
