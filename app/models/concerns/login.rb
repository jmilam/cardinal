class Login
	def validate_fields(fields)
		fields.each do |key, value|
			if value.empty?
				raise 
			end
		end
	end
end