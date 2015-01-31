require 'data_mapper'
require 'sinatra/base'

class DB < Sinatra::Base

	set :views, Proc.new { File.join(root, '..',"views") }
	set :public_dir, Proc.new{File.join(root, '..', "public")}
  set :public_folder, '/public'
 	# set :static, true
 	# set :root, File.dirname(__FILE__)

	env = ENV['RACK_ENV'] || 'development'

	DataMapper.setup(:default, "postgres://localhost/db_#{env}")

	require './lib/link'
	require './lib/tag'

	DataMapper.finalize

	# DataMapper.auto_migrate! 

	get '/' do
		# links = Link.all
		# links.destroy
		# tag = Tag.all
		# tag.destroy
		# fill_database
		@links = Link.all	
		@tags = Tag.all
		erb :index
	end

	post '/links' do
	  url = params['url']
	  title = params["title"]
	  blog = params["blog"]
	  tags = params["tags"].split(" ").map do |tag|
  		Tag.first_or_create(:text => tag)
		end
		Link.create(:url => url, :title => title, :blog => blog, :tags => tags)
	  redirect to('/')
	end

	# get '/tags/:text' do
	#   tag = Tag.first(:text => params[:text])
	#   @links = tag ? tag.links : []
	#   erb :index	
	# end

	get '/tags/:genre' do |genre|
		@tags = Tag.all
		tag = Tag.all(:text => genre)
		@links = tag.links 
		erb :filtered
	end

	# get '/Folk' do
	# 	@tags = Tag.all
	# 	tag = Tag.all(:text => "Folk")
	# 	@links = tag.links
	# 	# erb :filtered
	# end

	# get '/Jungle' do
	# 	@tags = Tag.all
	# 	tag = Tag.all(:text => "Jungle")
	# 	@links = tag.links
	# 	# erb :filtered
	# end


	# def fill_database
	# 	tags = "House ChillOut Jungle"
	# 	tags = tags.split(" ").map { |tag| Tag.first_or_create(:text => tag)}
	# 	Link.create(:url => '<iframe width="560" height="315" src="https://www.youtube.com/embed/t6bjqdll7DI" frameborder="0" allowfullscreen></iframe>', :title => "Rodriguez", :blog => "The man the legend")
	# 	Link.create(:url => '<iframe width="100%" height="200" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/179602402&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;visual=true"></iframe>', :title => "Max Cooper", :blog => "Super chilled", :tags => tags)
	# 	Link.create(:url => '<iframe width="100%" height="200" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/155628096&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;visual=true"></iframe>', :title => "DJ Vadim", :blog => "Sunny goodness", :tags => tags)
	# 	Link.create(:url => '<iframe width="100%" height="200" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/175495275&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;visual=true"></iframe>', :title => "Stivs", :blog => "Badman Ting")
	# end

end