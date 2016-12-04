# frozen_string_literal: true

class DevRankAPP < Sinatra::Base 

  get '/repository' do
    slim :repository
  end
end
