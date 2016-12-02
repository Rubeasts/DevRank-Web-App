class GetDeveloper
  extend Dry::Monads::Either::Mixin

  def self.call(developer)
  	results = HTTP.get("#{DevRankAPP.config.DEVRANK_API}/dev/#{developer}")
  	Right(results.parse)
  rescue
  	Left(Error.new('Weird things are happening - but no one cares!'))
  end
end
