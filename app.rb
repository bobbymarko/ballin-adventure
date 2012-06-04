require 'sinatra'
require 'vacuum'

get '/asin/:asin' do # example asin: B000O9WEY2
  req = Vacuum.new :product_advertising

  req.configure do |config|
    config.key    = ENV['amazon_key']
    config.secret = ENV['amazon_secret']
    config.tag    = 'wefouadv-20'
  end
  
  req.build operation:	    'ItemLookup',
            item_id:        params[:asin],
            response_group: 'ItemAttributes,Images'
  	
  res = req.get
  
  res.valid? or raise res.code
  
  @products = res
  
  haml :index
  
end