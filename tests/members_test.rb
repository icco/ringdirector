# test.rb
require File.expand_path '../test_helper.rb', __FILE__

class MembersTest < Minitest::Test

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  # test parsing all urls in file
  def test_sites
    sites.each do |s|
      assert_match /\A#{URI::regexp(['http', 'https'])}\z/, s.to_s
    end
  end
end

