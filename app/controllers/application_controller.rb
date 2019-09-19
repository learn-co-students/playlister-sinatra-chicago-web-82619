

class ApplicationController < Sinatra::Base
  require 'rack-flash'

  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }
  use Rack::Flash
  enable :sessions


  get '/' do
    erb :index
  end
end
