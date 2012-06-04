require 'sinatra'

get '/' do
  req = Vacuum.new :product_advertising

  req.configure do |config|
    config.key    = ENV['amazon_key']
    config.secret = ENV['amazon_secret']
    config.tag    = 'wefouadv-20'
  end
  
  req.build operation:  'ItemSearch',
          search_index: 'Books',
          keywords:     'Deleuze'
  res = req.get
  
  res.valid? or raise res.code
  
  p res.body
  
end