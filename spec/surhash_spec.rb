require './lib/surhash'
require './spec/spec_helper'

# Contexts

RSpec.shared_context 'empty' do
  subject do
    SurHash.empty
  end
end
RSpec.shared_context 'one-to-one' do
  subject do
    SurHash[ 'A'  =>  1 ]
  end
end
RSpec.shared_context 'many-to-one' do
  subject do
    SurHash[  [ 'A', 'B', 'C' ] =>  1 ]
  end
end
RSpec.shared_context 'complex' do
  subject do
    SurHash[
        'A'               =>  1,
        'B'               =>  2,
        [ 'C', 'D' ]      =>  3,
        'E'               =>  4,
        [ 'F', 'G', 'H' ] =>  5,
        [ 'I', 'J' ]      =>  6,
        'K'               =>  7,
      ]
  end
end


# Examples

RSpec.describe SurHash do
  describe '.[]' do
    include_context 'complex'

    it 'constructs a surhash from a complex literal' do
      subject.should_not be_empty
      subject.size.should eq 11
      subject.keys.size.should eq 11
      subject.values.size.should eq 7
      subject.keys.should eq ('A'..'K').to_a
      subject.values.should eq (1..7).to_a
      subject.entries.should eq [
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
    include_context 'empty'

    it 'returns an empty surhash' do    
      subject.should be_empty
      subject.keys.should be_empty
      subject.values.should be_empty
    end
  end
  describe '.empty?' do
    context 'empty' do
      include_context 'empty'

      it 'return true if the surhash is empty' do
        subject.empty?.should be true
      end
    end
    context 'not empty'
      include_context 'many-to-one'

      it 'returns false if the surhash contains elements' do
        subject.empty?.should be false
      end
    end
  end
  describe '#size' do
    context 'empty' do
      include_context 'empty'
      it 'should return 0 if the surhash is empty' do
        subject.size.should eq 0
      end
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