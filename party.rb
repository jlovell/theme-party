require 'sinatra'
require 'pony'
require 'haml'
require 'sass'

RANDOMS = [
  'a war of 1812 party',
  'a water-less pool party',
  'christmas in august',
  'a celebrity couples party',
  'an angels and devils party',
  'a masquerade',
  'a medieval party',
  'a hawaiian luau',
  'a casino party',
  'a toga party',
  'a mustache party',
  'a wild west party',
  'a ninja party',
  'a neon party',
  'a groovy disco',
  'a pirate party',
  'a crazy hat party',
  'a frat/sorority party'
]

get '/' do end
get '/favicon.ico' do end

get '/:name' do |name|
  name &&= name.downcase
  cookie = request.cookies['invitee']
  # return "cheater" if cookie && !name[cookie]
  response.set_cookie 'invitee', name

  @name =
  case name
  when 'jason' then 'Jason Lovell'
  when 'will'  then 'Will Thwaites'
  else name.capitalize
  end

  @theme =
  case name
  when 'jason' then 'a mexican fiesta'
  when 'will'  then 'a spring break party'
  else
    RANDOMS[Random.new(name.codepoints.inject(:+)).rand(RANDOMS.size)]
  end

  haml :invite
end

post '/respond' do
  Pony.mail({
    to:      "jason@zoomcc.com",
    subject: "Theme party response #{params[:response]}",
    body:    "#{params[:name][1..-1]} - #{params[:response]}",
    via:     :smtp,
    via_options: {
      address:              'smtp.gmail.com',
      port:                 '587',
      enable_starttls_auto: true,
      user_name:            'jason@zoomcc.com',
      password:             ENV['GMAIL_KEY'] || 'rvgxxkzrhlfnboev',
      authentication:       :plain,
      domain:               "party.thwovell.com"
    }
  })
end
