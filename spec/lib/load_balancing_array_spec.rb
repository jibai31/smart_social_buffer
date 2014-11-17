require 'load_balancing_array'
require 'support/load_balancing_array_macros'
RSpec.configure{|c| c.include LoadBalancingArrayMacros}

describe LoadBalancingArray do

  let(:array) { LoadBalancingArray.new(5) }
  let(:item)  { double }

  describe "#initialize" do
    it "creates N piles" do
      expect(array.piles.size).to eq 5
    end
  end

  context "when empty" do
    describe "#add item" do
      it "does nothing for nil item" do
        array.add(nil)
        expect(array).to be_of_size [0, 0, 0, 0, 0]
      end

      it "adds the item to the middle pile" do
        array.add(item)
        expect(array).to be_of_size [0, 0, 1, 0, 0]
      end
    end

    describe "#spread several items" do
      it "adds 1 item in the middle" do
        array.spread([item])
        expect(array).to be_of_size [0, 0, 1, 0, 0]
      end
      it "adds 2 items homogeneously" do
        array.spread(2.times.collect{item})
        expect(array).to be_of_size [0, 1, 0, 1, 0]
      end
      it "adds 3 items homogeneously" do
        array.spread(3.times.collect{item})
        expect(array).to be_of_size [1, 0, 1, 0, 1]
      end
      it "adds 4 items homogeneously" do
        array.spread(4.times.collect{item})
        expect(array).to be_of_size [1, 1, 1, 0, 1]
      end
      it "adds 5 items homogeneously" do
        array.spread(5.times.collect{item})
        expect(array).to be_of_size [1, 1, 1, 1, 1]
      end
      it "adds 6 items homogeneously" do
        array.spread(6.times.collect{item})
        expect(array).to be_of_size [2, 1, 1, 1, 1]
      end
      it "adds 7 items homogeneously" do
        array.spread(7.times.collect{item})
        expect(array).to be_of_size [2, 1, 2, 1, 1]
      end
    end
  end

  context "with items" do
    describe "#add item" do
      it "adds the item to the smallest pile" do
        array = create_array [1, 0, 0, 1, 0]
        array.add(item)
        expect(array).to be_of_size [1, 1, 0, 1, 0]
      end
    end

    describe "#spread several items" do
      it "adds 1 item in smallest pile" do
        array = create_array [0, 0, 1, 0, 0]
        array.spread([item])
        expect(array).to be_of_size [1, 0, 1, 0, 0]
      end
      it "adds 4 item in smallest pile" do
        array = create_array [0, 0, 1, 0, 0]
        array.spread(5.times.collect{item})
        expect(array).to be_of_size [2, 1, 1, 1, 1]
      end
    end
  end
end
