require 'sinatra'
require 'pony'
require 'haml'
require 'sass'

RANDOMS = [
  'war of 1812 party',
  'water-less pool party',
  'christmas in august',
  'mexican fiesta',
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
  'frat/sorority party',
  'migrant workers party',
  'Sunny and Share party',
  'anything but booze party',
  'obscure sports party',
  'business hoes and CEOs party',
  'famous cereal mascots party',
  'teen vampires party',
  'exotic birds party',
  'monopoly party',
  'biblical plagues party',
  'democratic convention party',
  'republican convention party'
]

get '/' do end
get '/favicon.ico' do end

get '/:name' do |name|
  name &&= name.downcase
  cookie = request.cookies['invitee']
  return haml "%p nice try." if cookie && !name[cookie]
  response.set_cookie 'invitee', cookie || name

  @name = name.capitalize

  @theme =
  case name
  when 'jason'       then 'mexican fiesta'
  when 'will'        then 'spring break party'
  when 'kyle'        then 'halloween party'
  when 'corinne'     then 'spring break party'
  when 'matt'        then 'superhero party'
  when 'shannon'     then 'cats party'
  when 'nate'        then 'easter party'
  when 'mary'        then 'French-American war'
  when 'sam', 'todd' then 'celebrity couples party'
  when 'ray'         then 'monopoly party'
  when 'zak'         then 'superhero party'
  else
    RANDOMS[Random.new(name.codepoints.inject(:+)).rand(RANDOMS.size)]
  end

  haml :invite
end

post '/respond' do
  Pony.mail({
    to:      "jason@zoomcc.com",
    subject: "Theme party response #{params[:response]}",
    body:    "#{params[:name][1..-1]} - #{params[:response]} - #{params[:theme]}",
    via:     :smtp,
    via_options: {
      address:              'smtp.gmail.com',
      port:                 '587',
      enable_starttls_auto: true,
      user_name:            'jason@zoomcc.com',
      password:             ENV['GMAIL_KEY'],
      authentication:       :plain,
      domain:               "party.thwovell.com"
    }
  })
end
