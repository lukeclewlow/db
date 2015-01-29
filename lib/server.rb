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
		links = Link.all
		links.destroy
		tag = Tag.all
		tag.destroy
		fill_database
		@links = Link.all(:limit => 10)		
		@tags = Tag.all
		erb :index
	end

	post '/links' do
	  url = params["url"]
	  title = params["title"]
	  blog = params["blog"]
	  tags = params["tags"].split(" ").map do |tag|
  		Tag.first_or_create(:text => tag)
		end
		Link.create(:url => url, :title => title, :blog => blog, :tags => tags)
	  redirect to('/')
	end

	get '/tags/:text' do
	  tag = Tag.first(:text => params[:text])
	  @links = tag ? tag.links : []
	  erb :index
	end

	def fill_database
		# Tag.first(:text => "House")
		Link.create(:url => "https://soundcloud.com/throwingsnow/max-cooper-origins-throwing-snow-remix-2", :title => "Max Cooper", :blog => "Super chilled")
		Link.create(:url => "https://soundcloud.com/dj-vadim/dj-vadim-if-life-was-a-thing-ft-demolition-man", :title => "DJ Vadim", :blog => "Sunny goodness")
		Link.create(:url => "https://soundcloud.com/born-on-road/stivs-katch-pyro-yuh-no-badman-born-on-road-004-clip", :title => "Stivs", :blog => "Badman Ting")
		Link.create(:url => "https://soundcloud.com/c3b/solskank", :title => "C3B", :blog => "Hardcore")
	end

end