# frozen_string_literal: true

RSpec.describe DspBlueprintParser do
  let(:blue_string) do
    File.read('spec/fixtures/blueprint.txt')
  end

  let(:blueprint) do
    DspBlueprintParser.parse(blue_string)
  end

  describe  'correct number of areas parsed' do
    subject { blueprint }
    its(:areas) { is_expected.to all(be_a(DspBlueprintParser::Area)) }
    its(:areas) { is_expected.to have_attributes(size: 1) }
  end
end
