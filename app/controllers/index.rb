enable :sessions

helpers do
  def user?
    session[:user]
  end
end


get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/login' do
  redirect to "/auth/twitter"
end

get '/auth/twitter/callback' do
  env['omniauth.auth'] ? session[:user] = true : halt(401,'Not Authorized')
  @user = User.find_or_create_by( 
    tweethandle: env['omniauth.auth']['info']['nickname'],
    token: env['omniauth.auth']['credentials']['token'],
    token_secret: env['omniauth.auth']['credentials']['secret']
    )
  @user.tweet_user
  session[:username] = @user[:tweethandle]
  redirect to "/home/#{@user.tweethandle}"
end

get '/home/:user' do
  session[:username] = params[:user]
  @user = User.find_by_tweethandle(params[:user])
  erb :home
end

get '/auth/failure' do 
  params[:message]
end

get '/tweet/update' do
  @user = User.find_by_tweethandle(session[:username])
  @tweet = @user.tweet_user
  @tweet.update(params[:update])
  erb :home
end

get '/logout' do
  session.clear

  redirect to '/'
end


# get '/private' do
#   halt(401,'Not Authorized') unless user?
#   "This is the private page - members only"
# end