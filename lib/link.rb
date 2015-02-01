class Link

		include DataMapper::Resource

		property :id,			Serial
		property :artist, String
		property :title,	String
		property :url,		Text
		property :blog, 	Text
		property :created_at,  DateTime
		
		has n, :tags, :through => Resource, :constraint => :destroy!



end
