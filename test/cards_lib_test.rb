require 'minitest_helper'

class CardsLibTest < Minitest::Spec
  def test_that_it_has_a_version_number
    refute_nil ::CardsLib::VERSION
  end

end
