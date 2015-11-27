require "cards_lib/version"
require "cards_lib/refinements" # REQUIRE BEFORE USE
require "cards_lib/card"
require "cards_lib/deck"
require "cards_lib/standard"
require "cards_lib/ranker"
require "cards_lib/is_set"

module CardsLib

  # Macro 
  # Cards[]
  #  generate Card instances from string
  #  representations of their faces
  Cards = ->*c{ c.map {|face| Card.new(face)} }
end
