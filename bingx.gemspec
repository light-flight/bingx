# frozen_string_literal: true

require_relative 'lib/bingx/version'

Gem::Specification.new do |spec|
  spec.name = 'bingx'
  spec.version = Bingx::VERSION
  spec.authors = ['Georgy Yuriev']
  spec.email = ['georgy.yuriev@gmail.com']

  spec.summary = 'Bingx on Ruby'
  spec.description = 'Bingx API connector'
  spec.homepage = 'https://rubygems.org/gems/bingx'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/light-flight/bingx'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split('\x0').reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '~> 0.21.0'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
