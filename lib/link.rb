class Link

		include DataMapper::Resource

		property :id,			Serial
		property :title,	String
		property :url,		Text
		property :blog, 	Text
		
		has n, :tags, :through => Resource

end
