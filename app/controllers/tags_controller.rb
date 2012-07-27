class TagsController < ApplicationController
	def index
		@tags = Entry.tag_counts(:order => 'name')
	end
	
	def show
		@entries = Entry.find_tagged_with(params[:id])
	end
end
