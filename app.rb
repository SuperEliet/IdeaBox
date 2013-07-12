class IdeaBoxApp <  Sinatra::Base
	set :method_override, true

  # ...
  configure :development do
  	register Sinatra::Reloader
  end

  require './idea'

  get '/' do
  	erb :index, locals: {ideas: Idea.all}
  end

  not_found do
  	erb :error
  end

  post '/' do 
  	idea = Idea.new(params['idea_title'], params['idea_description'])
  	idea.save
  	redirect '/'
  end

  delete '/:index' do |index|
  	"DELETING an idea!"
  	Idea.delete(index.to_i)
  	redirect '/'
  end
end