$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'cards_lib'
require 'minitest/autorun'
require 'minitest/reporters'
require 'color_pound_spec_reporter'

Minitest.backtrace_filter = Minitest::BacktraceFilter.new

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

Minitest::Reporters.use! [ColorPoundSpecReporter.new]

include CardsLib
