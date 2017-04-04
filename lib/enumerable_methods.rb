# Recreate some of the Enumerable methods.

module Enumerable

	def my_each(&block)
		i = 0
		while i < self.size
			block.call(self[i])
			i += 1
		end
	end

	def my_each_with_index(&block)
		i = 0
		while i < self.size
			block.call(self[i], i)
			i += 1
		end
	end

	def my_select(&block)
		results = []
		self.my_each do |elem|
			if block.call(elem)
				results.push elem
			end
		end
		results
	end

	def my_all?(&block)
		answer = true
		if block_given?
			self.my_each do |elem|
				if !block.call(elem)
					answer = false
				end
			end
		else
			self.my_each do |elem|
				if !elem
					answer = false
				end
			end
		end
		answer
	end

	def my_any?(&block)
		answer = false
		if block_given?
			self.my_each do |elem|
				if block.call(elem)
					answer = true
				end
			end
		else
			self.my_each do |elem|
				if elem
					answer = true
				end
			end
		end
		answer
	end

	def my_none?(&block)
		answer = true
		if block_given?
			self.my_each do |elem|
				if block.call(elem)
					answer = false
				end
			end
		else
			self.my_each do |elem|
				if elem
					answer = false
				end
			end
		end
		answer
	end

	def my_count(arg=nil)
		sum = 0
		if block_given? && arg == nil
			self.my_each do |elem|
				if yield(elem)
					sum += 1
				end
			end
		elsif !block_given? && arg != nil
			self.my_each do |elem|
				if arg == elem
					sum += 1
				end
			end
		else
			self.my_each do |elem|
				sum += 1
			end
		end
		sum
	end

	def my_map(arg=nil)
		mapped_array = []
		if arg != nil && arg.respond_to?(:call)
			self.my_each do |elem|
				mapped_array.push arg.call(elem)
			end
		elsif arg == nil && block_given?
			self.my_each do |elem|
				mapped_array.push yield(elem)
			end
		end

		mapped_array
	end

	def my_inject(arg=nil,&block)
		if arg != nil && (arg.is_a? Integer)
			total = arg
		elsif arg != nil
			raise "Your argument must be an integer"
		else
			total = self.first
		end

		self.my_each_with_index do |elem,index|
			next if index == 0 && arg == nil
			total = block.call(total,elem)
		end
		total
	end

	def multiply_els
		self.my_inject { |total, elem| total *= elem }
	end

end

# Tests:
=begin
sample = [1, 5, 5, 8, 10, 19]

sample.my_each_with_index { |x, y| puts "Element #{x} has index #{y}"}
puts sample.my_select { |x| x % 5 == 0 }
puts
puts sample.my_all? { |x| x.is_a?(Integer) }
puts 
puts sample.my_none? { |x| x.is_a?(Integer) }
puts
puts [nil, nil].my_none?
puts
puts [nil, 1].my_any?
puts sample.my_none?
puts sample.my_all?
puts [nil, false, 2, "my"].my_all?
puts sample.my_map { |x| x * 2}
puts sample.my_inject { |sum, n| sum + n } 
puts sample.my_inject(15) { |sum, n| sum + n }
puts sample.multiply_els
pr = Proc.new { |x| x * 2 }
l = lambda { |x| x * 2 }
puts sample.my_map(pr)
puts sample.my_map { |x| x + 1}
puts sample.my_map(pr) { |x| x + 10}
puts sample.my_count { |x| x % 5 == 0}
puts sample.my_count

=end