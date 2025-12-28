# frozen_string_literal: true

require_relative 'lib/dsp_blueprint_parser/version'

Gem::Specification.new do |spec|
  spec.name          = 'dsp_blueprint_parser'
  spec.version       = DspBlueprintParser::VERSION
  spec.authors       = ['Lucas Falk']
  spec.email         = ['LRFalk01@gmail.com']

  spec.summary       = 'Parse Dyson Sphere Program blueprint string'
  spec.description   = 'Parse Dyson Sphere Program blueprint string'
  spec.homepage      = 'https://github.com/LRFalk01/DSP-Blueprint-Parser'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.0'

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'https://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  # spec.metadata['changelog_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.add_development_dependency "rake-compiler", "~> 1.0"

  spec.extensions = %w[ext/md5f/extconf.rb]
end
