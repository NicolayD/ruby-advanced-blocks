# Define a method that uses bubble sorting to sort an array.
# THen define a new bubble sort method that accepts a block
# with two elements compared in the same way as with the 
# spaceship operator.


def bubble_sort(array)

	while true
		swaps = 0

		array.each_index do |ind|
			if (ind < array.length - 1) && (array[ind] > array[ind + 1])
				array[ind], array[ind + 1] = array[ind + 1], array[ind]
				swaps += 1
			end
		end

		break if swaps == 0
	end

	array
end

puts bubble_sort([1, 5, 3, 8, 5, 19, 23, 69, 27, 81, 2])

def bubble_sort_by(array, &block)

	while true
		swaps = 0

		array.each_index do |ind|
			if ind < array.length - 1
			result = block.call(array[ind], array[ind + 1])
				if result > 0
					array[ind], array[ind + 1] = array[ind + 1], array[ind]
					swaps += 1
				end
			end
		end

		break if swaps == 0
	end
	
	array
end

puts

puts bubble_sort_by([1, 5, 3, 8, 3, 19, 23, 69, 27, 81, 2]) { |left, right| right - left }

puts

puts bubble_sort_by(["hi","hello","hey", "say", "so"]) { |left,right| left.length - right.length }