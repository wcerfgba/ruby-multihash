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

  describe '#empty?' do

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

      it 'returns 0 if the surhash is empty' do
        subject.size.should eq 0
      end
    end

    context 'not empty' do
      include_context 'many-to-one'

      it 'returns >= 0 if the surhash is not empty' do
        subject.size.should be > 0
      end
    end
  end

  describe '#keys' do

    context 'empty' do
      include_context 'empty'

      it 'returns an empty array if the surhash is empty' do
        subject.empty?.should be true
        subject.keys.empty?.should be true
      end
    end

    context 'not empty' do
      include_context 'many-to-one'

      it 'returns a non-empty array of all keys if the surhash is not empty' do
        subject.empty?.should be false
        subject.keys.empty?.should be false
        subject.keys.should include 'A'
        subject.keys.should include 'B'
        subject.keys.should include 'C'
        subject.keys.should_not include 'D'
      end
    end
  end

  describe '#values' do

    context 'empty' do
      include_context 'empty'

      it 'returns an empty array if the surhash is empty' do
        subject.empty?.should be true
        subject.values.empty?.should be true
      end
    end

    context 'not empty' do
      include_context 'complex'

      it 'returns a non-empty array of all values if the surhash is not empty' do
        subject.empty?.should be false
        subject.values.empty?.should be false
        subject.values.should include 1
        subject.values.should include 2
        subject.values.should include 3
        subject.values.should include 4
        subject.values.should include 5
        subject.values.should include 6
        subject.values.should include 7
        subject.values.should_not include 8
      end
    end
  end

  describe '#get' do

    context 'empty' do
      include_context 'empty'

      it 'returns nil if surhash is empty' do
        subject.empty?.should be true
        subject.get('test').should be nil
      end
    end

    context 'not empty' do
      include_context 'one-to-one'

      it 'returns nil if the key is not present' do
        subject.empty?.should be false
        subject.get('B').should be nil
      end

      it 'returns the value if the key is present' do
        subject.empty?.should be false
        subject.get('A').should be 1
      end
    end
  end

  describe '#==' do

    context 'not empty' do
      include_context 'complex'

      it 'returns true if two surhashes have exactly the same entries' do
        other = subject.clone

        subject.==(other).should be true
      end

      it 'returns false if two surhashes have different entries' do
        other = SurHash[  'A' =>  1 ]

        subject.==(other).should be false
      end
  end
end