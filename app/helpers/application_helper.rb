# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def tag_cloud(tags, classes)
		max, min = 0, 0
		tags.each do |tag|
			max = tag.count if tag.count > max
			min = tag.count if tag.count < min
		end
		
		divisor = ((max-min) / classes.size) + 1
		
		tags.each do |tag|
			yield tag.name, classes[(tag.count - min) / divisor]
		end
	end
end
