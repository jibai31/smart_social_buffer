# Macros kept as a reference (not used anymore)
#
# To use such a macro, the spec needs to do the following:
#
# require 'service_under_test'
# require 'support/load_balancing_array_macros'
# RSpec.configure{|c| c.include LoadBalancingArrayMacros}
#
module LoadBalancingArrayMacros

  RSpec::Matchers.define :be_of_size do |expected_sizes|
    match do |array|
      array.pile_sizes == expected_sizes
    end

    failure_message do |array|
      "It expected size [#{expected_sizes.join(', ')}] but got [#{actual.pile_sizes.join(', ')}]"
    end

    failure_message_when_negated do |array|
      "It expected size not to be [#{expected_sizes.join(', ')}]"
    end

  end

  def create_array(sizes)
    array = LoadBalancingArray.new(sizes.size)
    sizes.each_with_index do |size, i|
      (1..size).each { array.piles[i] << double }
    end
    array
  end
end
