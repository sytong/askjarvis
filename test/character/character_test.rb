#test/character/character_test.rb
require './test/test_helper'

class AskjarvisCharacterTest < Minitest::Test
  def test_exists
    assert Askjarvis::Character
  end

  def test_we_have_a_hulk
    Askjarvis.stub :default_query_params, "ts=111&apikey=111&hash=111" do
  	  VCR.use_cassette('the_hulk') do
  	    the_hulk = Askjarvis::Character.find(1009351)
  	    assert_equal Askjarvis::Character, the_hulk.class

  	    assert_equal 1009351, the_hulk.id
  	    assert_equal 'Hulk', the_hulk.name
      end
  	end
  end
end