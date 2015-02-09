require 'data_mapper'
require 'sinatra/base'

class DB < Sinatra::Base

	set :views, Proc.new { File.join(root, '..',"views") }
	# set :public_dir, Proc.new{File.join(root, '..', "public")}
 #  set :public_folder, '/public'
 	# set :static, true
 	# set :root, File.dirname(__FILE__)

	env = ENV['RACK_ENV'] || 'development'

	DataMapper.setup(:default, "postgres://localhost/db_#{env}")

	require './lib/link'
	require './lib/tag'

	DataMapper.finalize
	# DataMapper.auto_upgrade!

	# DataMapper.auto_migrate! 

	get '/' do
		@links = Link.all(:order => :created_at.desc)
		@tags = Tag.all(:order => :text.asc)
		erb :index
	end

	post '/links' do
	  url = params['url']
	  artist = params["artist"]
	  title = params["title"]
	  blog = params["blog"]
	  tags = params["tags"].split(" ").map do |tag|
  		Tag.first_or_create(:text => tag)
		end
		Link.create(:url => url, :artist => artist, :title => title, :blog => blog, :tags => tags)
	  redirect to('/')
	end

	delete '/:delete' do 
		link = Link.all(:title => params[:delete])
		if link.destroy!
		  redirect to('/') 
		else
			erb :index
		end
	end

	get '/tags/:genre' do |genre|
		@tags = Tag.all(:order => :text.asc)
		tag = Tag.all(:text => genre)
		@links = tag.links 
		erb :filtered
	end	

	

end