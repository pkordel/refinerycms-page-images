require 'spec_helper'
require_relative '../../lib/image_attributes_parser'

describe ImageAttributesParser do
  let(:attributes) do
    {
      '0'   => { 'id' => '46', 'image_page_id' => '33' },
      'top' => { 'top_image' => '33' },
      '1'   => { 'id' => '45' }
    }
  end

  it 'parses with top image' do
    parsed = ImageAttributesParser.parse(attributes)
    expect(parsed.size).to eq 2
    expected = [
      ImagePageVO.new('46', '33', '0', true, nil),
      ImagePageVO.new('45', nil, '1', false, nil)
    ]
    expect(parsed).to match_array expected
  end

  context 'with one image' do
    let(:attributes) do
      {
        '0'   => { 'id' => '46' }
      }
    end

    it 'is successful' do
      parsed = ImageAttributesParser.parse(attributes)
      expect(parsed).to match_array [
        ImagePageVO.new('46', nil, '0', false, nil)
      ]
    end
  end
end
