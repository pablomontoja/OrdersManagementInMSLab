module OrdersHelper

def my_counter
	date = Time.now.to_s
	number = 1
	if Order.last.nil?
		if number == nil 
			return "1/#{date[2..3]}"
		else
			return "#{number}/#{date[2..3]}"
		end
	else
		year = Order.last.number
		my_number = year[0..-4].to_i

		if year[-2..-1] == date[2..3]
			return "#{my_number + 1}/#{date[2..3]}"
		else
			return "1/#{date[2..3]}"
		end

	end
end

end
