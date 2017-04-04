require 'spec_helper'
require 'enumerable_methods'

describe 'Enumerable' do 

	let(:array) { [7, 9, 13] }
	let(:array2) { ["I", "like", "books"]}
	let(:array3) { ["Positive", 7, "thinking", 3.14, "always"]}
	let(:new_array) { [] }

	context '#my_each' do 
		it 'correctly traverses each element' do
			expect { |block|  array.my_each(&block) }.to yield_successive_args(7, 9, 13)
		end

		# Deliberate failure
		it 'incorrectly traverses the array' do
			expect { |block| array.my_each(&block) }.to yield_successive_args(5,10,15)
		end

		it 'correctly applies block to each element' do
			array.my_each { |el| new_array.push el * 2 }
			expect(new_array).to eq([14, 18, 26])
		end
	end

	context '#my_each_with_index' do
		it 'yields elements and indices' do
			expect { |block| array.my_each_with_index(&block) }.to yield_successive_args([7,0],[9,1],[13,2])
		end

		# Deliberate failure
		it 'incorrectly yields arguments' do
			expect { |block| array.my_each_with_index(&block) }.to yield_successive_args([5,2],[98,23],[365,3.12])
		end
	end

	context "#my_select" do
		it 'returns the elements specified by the block' do
			new_array = array.my_select { |el| el < 10 }
			expect(new_array).to eq([7,9])
		end

		# Deliberate failure
		it 'does not return the specified elements' do
			new_array = ["hey", "hello", "cheers", "sup", "good day"].my_select { |el| el.length > 3 }
			expect(new_array).to eq(["hey", "sup"])
		end

	end

	context "#my_all?" do
		it 'returns true if all elements are integers' do
			expect(array.my_all? { |el| el.is_a? Integer }).to be_true
		end

		it 'returns false if the block looks for strings' do
			expect(array.my_all? { |el| el.is_a? String }).to be_false
		end
	end

	context "#my_any?" do
		it 'returns true if any elements is an integer' do
			expect(array.my_any? { |el| el.is_a? Integer }).to be_true
		end

		it 'returns true if any element is a string' do
			expect(array2.my_any? { |el| el.is_a? String }).to be_true
		end

		it 'returns false if no element is an integer' do
			expect(array2.my_any? { |el| el.is_a? Integer }).to be_false
		end

		it 'returns true if any element is a string from a mixed array' do
			expect(array3.my_any? { |el| el.is_a? String }).to be_true
		end
	end

	context "#my_none?" do
		it 'returns true if no elements are integers' do
			expect(array2.my_none? { |el| el.is_a? Integer }).to be_true
		end

		it 'returns false if any element is an integer' do
			expect(array3.my_none? { |el| el.is_a? Integer }).to be_false
		end
	end

	context "#my_count" do
		it 'returns 3 if all three elements can\'t be divided by 2' do
			expect(array.my_count { |el| el % 2 == 0 }).to eq(0)
		end

		it 'returns 3 if three elements are strings' do
			expect(array3.my_count { |el| el.is_a? String }).to eq(3)
		end

		it 'returns 1 if one element is a float' do
			expect(array3.my_count { |el| el.is_a? Float }).to eq(1)
		end
	end

	context "#my_map" do
		it 'changes every element (all integers)' do
			new_array = array.my_map { |el| el * 7 }
			expect(new_array).to eq([49, 63, 91])
		end

		it 'changes every element (all strings)' do
			new_array = array2.my_map { |el| el << "lololo" }
			expect(new_array).to eq(["Ilololo", "likelololo", "bookslololo"])
		end
	end

	context "#my_inject" do
		it 'sums up all integers from array' do
			expect(array.my_inject { |sum,el| sum += el }).to eq(29)
		end

		it 'starts from the initial value if it\'s present' do
			expect(array.my_inject(10) { |sum,el| sum += el }).to eq(39)
		end
	end

	context "#multiply_els" do
		it 'multiplies all integers in array' do
			expect(array.multiply_els).to eq(819)
		end
	end
end