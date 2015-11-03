require "rspec"
require_relative "../lib/board.rb"

describe "#in_bounds?" do
  let(:b) { Board.new }
  it "returns true for [0,0]" do
    expect(b.in_bounds?([0,0])).to eq(true)
  end
  it "returns false for [-1,0]" do
    expect(b.in_bounds?([-1,0])).to eq(false)
  end
end

describe "#create_board" do
  let(:b) { Board.new }
  it "returns true for [0,0]" do
    expect( b[[0,0]].class ).to eq(Rook)
  end
end


# describe "#move" do
#   let(:b) { Board.new }
#   it "returns true for [0,0]" do
#     expect( b.move([0,0],[0,5]) ).to eq(Rook)
#   end
# end
