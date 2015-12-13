$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
require 'cards_lib'
require 'minitest/autorun'
require 'minitest/reporters'
require 'color_pound_spec_reporter'
require 'minitest/byebug' if ENV["DEBUG"]

Minitest.backtrace_filter = Minitest::BacktraceFilter.new

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

Minitest::Reporters.use! [ColorPoundSpecReporter.new]

include CardsLib
