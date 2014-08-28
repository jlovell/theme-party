require 'sinatra'
require 'haml'
require 'sass'

get '/' do end
get '/favicon.ico' do end

get '/:name' do |name|
  name &&= name.downcase
  cookie = request.cookies['invitee']
  # return "cheater" if cookie && cookie != name
  response.set_cookie 'invitee', name

  @name =
  case name
  when 'jason' then 'Jason Lovell'
  when 'will'  then 'Will Thwaites'
  end

  @theme =
  case name
  when 'jason' then 'mexican fiesta'
  when 'will'  then 'spring break'
  else ['war of 1812', 'water-less pool', 'celebrity couples'].sample
  end

  haml :party
end
