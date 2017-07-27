require './lib/multihash'

# one day...
# require 'faker'

RSpec.describe MultiHash do
  describe '.[]' do
    it 'constructs a multihash from a complex literal' do
      actual = MultiHash[
        'A'               =>  1,
        'B'               =>  2,
        [ 'C', 'D' ]      =>  3,
        'E'               =>  4,
        [ 'F', 'G', 'H' ] =>  5,
        [ 'I', 'J' ]      =>  6,
        'K'               =>  7,
      ]

      actual.should_not be_empty
      actual.size.should eq 11
      actual.keys.size.should eq 11
      actual.values.size.should eq 7
      actual.keys.should eq 'A'..'K'
      actual.values.should eq 1..7
      actual.entries.should eq [
        [ 'A', 1 ],
        [ 'B', 2 ],
        [ 'C', 3 ],
        [ 'D', 3 ],
        [ 'E', 4 ],
        [ 'F', 5 ],
        [ 'G', 5 ],
        [ 'H', 5 ],
        [ 'I', 6 ],
        [ 'J', 6 ],
        [ 'K', 7 ],
      ]
    end
  end
  describe '.empty' do
    it 'returns an empty MultiHash' do
      actual = MultiHash.empty
      
      actual.should be_empty
      actual.keys.should be_empty
      actual.values.should be_empty
    end
  end
  describe '.empty?' do
  end
  describe '#size' do
  end
  describe '#keys' do
  end
  describe '#values' do
  end
  describe '#get' do
  end
  describe '#==' do
  end
end