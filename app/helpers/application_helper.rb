module ApplicationHelper
	def header(text)
		content_for(:header) { text.to_s }
	end

	def phone_number_link(text)
	    sets_of_numbers = text.scan(/[0-9]+/)
	    number = "+1-#{sets_of_numbers.join('-')}"
	    link_to text, "tel:#{number}"
    end
end
