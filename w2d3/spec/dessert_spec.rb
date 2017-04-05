require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  subject(:food) { Dessert.new("garbage", 10, chef) }
  let(:chef) { double("chef") }

  describe "#initialize" do
    it "sets a type" do
      expect(food.type).to eq('garbage')
    end

    it "sets a quantity" do
      expect(food.quantity).to eq(10)
    end

    it "starts ingredients as an empty array" do
      expect(food.ingredients).to be_empty
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new("ice cream", "fuktunz", chef)}.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      expect(food.ingredients).to_not include('stuff')
      food.add_ingredient("stuff")
      expect(food.ingredients).to include('stuff')
    end
  end

  describe "#mix!" do
    let(:snack) {['newspaper', 'water lilies', 'nitric acid']}
    before(:each) do
      food.add_ingredient("newspaper")
      food.add_ingredient("water lilies")
      food.add_ingredient("nitric acid")
    end

    it "shuffles the ingredient array" do
      expect(food.ingredients).to eq(snack)
      food.mix!
      expect(food.ingredients).to_not eq(snack)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      food.eat(2)
      expect(food.quantity).to eq(8)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { food.eat(12) }.to raise_error('not enough left!')
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Chef")
      expect(food.serve).to eq("Chef has made 10 garbages!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(food)
      food.make_more
    end
  end
end
