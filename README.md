# DspBlueprintParser

Small Ruby gem to handle parsing of Dyson Sphere Program's blueprint data.

Currently the gem does not support validating the MD5 hash of the blueprint. It appears as if the DSP devs wrote their own MD5 algorithm which would need it's own Ruby port. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dsp_blueprint_parser'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install dsp_blueprint_parser

## Usage

Module `DspBlueprintParser` has a single static method `parse` which takes the DSP blueprint string to be parsed.

```ruby
DspBlueprintParser.parse(str_blueprint)
```

This method returns a [BlueprintData](https://github.com/LRFalk01/DSP-Blueprint-Parser/blob/master/lib/dsp_blueprint_parser/blueprint_data.rb) object which includes the various metadata of the blueprint.
Part of the `BlueprintData` object are properties for [areas](https://github.com/LRFalk01/DSP-Blueprint-Parser/blob/master/lib/dsp_blueprint_parser/area.rb) and [buildings](https://github.com/LRFalk01/DSP-Blueprint-Parser/blob/master/lib/dsp_blueprint_parser/building.rb) which are what one would mostly be interested in further evaluating.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Running `rake compile` requires `gem install rake-compiler` to build the md5f extension.

Bug reports and pull requests are welcome on GitHub at https://github.com/LRFalk01/dsp_blueprint_parser.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
