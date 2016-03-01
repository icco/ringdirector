RACK_ENV ||= ENV["RACK_ENV"] ||= "development" unless defined?(RACK_ENV)

require "rubygems" unless defined?(Gem)
require "bundler/setup"
Bundler.require(:default, RACK_ENV)

require 'uri'
require 'yaml'
require 'tilt/erubis'

configure do
  enable :caching
  set :logging, true
  set :protection, true
end

get '/' do
  erb :index
end

get '/next' do
  # Try to figure out who is sending us this request.
  referrer = ""
  if params["referrer"] && valid_site?(params["referrer"])
    referrer = params["referrer"]
  end
  if request.referrer != "/" && valid_site?(request.referrer)
    referrer = request.referrer
  end

  redirect next_site(referrer)
end

# A valid site is a site in the members file.
def valid_site? url
  return sites.include? URI(url)
end

# Get the next site to redirect to. Pick a random one if the current site isn't
# provided.
def next_site referrer = ""
  if valid_site? referrer
    idx = sites.index(URI(referrer))
    nxt = (idx + 1) % sites.size
    return sites[nxt]
  end

  return sites.sample
end

# Return an array of URIs who are members of the webring.
#
# TODO: Cache so we aren't reading from file every hit.
def sites
  data = YAML.load(File.read("members.yml"))
  return data["sites"].map do |s|
    URI(s)
  end
end
