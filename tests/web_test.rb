require File.expand_path '../test_helper.rb', __FILE__

class WebTest < Minitest::Test

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index
    get '/'
    assert last_response.ok?
  end

  def test_next
    get '/next'
    assert last_response.redirect?
  end
end
