require 'sinatra'
require 'pony'
require 'haml'
require 'sass'

RANDOMS = [
  'war of 1812 party',
  'water-less pool party',
  'christmas in august',
  'celebrity couples party',
  'angels and devils party',
  'masquerade',
  'medieval party',
  'hawaiian luau',
  'casino party',
  'toga party',
  'mustache party',
  'wild west party',
  'ninja party',
  'neon party',
  'groovy disco party',
  'pirate party',
  'crazy hat party',
  'frat/sorority party'
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
  when 'jason' then 'mexican fiesta'
  when 'will'  then 'spring break party'
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
