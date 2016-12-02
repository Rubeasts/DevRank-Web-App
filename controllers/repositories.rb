 class DevRankAPP < Sinatra::Base 

  get '/repository' do
    slim :repository
  end
end
