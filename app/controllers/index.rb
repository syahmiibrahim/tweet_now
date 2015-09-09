get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/tweet/update' do
  $twitter.update(params[:update])
  redirect to '/'
end

