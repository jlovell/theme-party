require 'sinatra'
require 'haml'
require 'sass'

get '/:name' do |name|
  name &&= name.downcase
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

  haml :index
end

__END__

@@index
%p
  = @name ? "#{@name}, you're" : "You're"
  invited to a #{@theme} party on Friday.

@@layout
%html
  %head
    %title #{@name}'s Invitation
    <link href='http://fonts.googleapis.com/css?family=Lato:300' rel='stylesheet' type='text/css'>
  :scss
    body {
      font-family: 'Lato', Calibri, Arial, sans-serif;
      color: #ffe8e7;
      background: #E96D65;
      font-weight: 300;
      overflow-x: hidden;
    }
    .main {
      max-width: 50em;
      padding: 2em;
      margin: 0 auto;
    }
    p { font-size: 4em; }
  %body
    .main
      = yield
