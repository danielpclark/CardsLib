source 'https://rubygems.org'

# Specify your gem's dependencies in CardsLib.gemspec
gemspec
gem "codeclimate-test-reporter", group: :test, require: nil
group :development do
  gem "guard"
  gem "guard-minitest"
end

if Gem::Dependency.new('', "~> 2.4.0").match?('', RUBY_VERSION)
  gem "json", git: 'https://github.com/flori/json', branch: 'v1.8'
else
  gem "json"
end
