# frozen_string_literal: true

RSpec.describe DspBlueprintParser, aggregate_failures: true do
  before(:all) do
    @blueprint = DspBlueprintParser.parse(File.read('spec/fixtures/blueprint.0.10.34.28326.txt'))
  end

  describe 'correct number of areas parsed' do
    subject { @blueprint }
    its(:areas) { is_expected.to all(be_a(DspBlueprintParser::Area)) }
    its(:areas) { is_expected.to have_attributes(size: 1) }
  end

  describe 'area is parsed correctly' do
    subject { @blueprint.areas.first }
    its(:anchor_local_offset_x) { is_expected.to be(0) }
    its(:anchor_local_offset_y) { is_expected.to be(0) }
    its(:area_segments) { is_expected.to be(200) }
    its(:height) { is_expected.to be(11) }
    its(:width) { is_expected.to be(11) }
    its(:index) { is_expected.to be(0) }
    its(:parent_index) { is_expected.to be(-1) }
    its(:tropic_anchor) { is_expected.to be(0) }
  end

  describe 'correct number of buildings parsed' do
    subject { @blueprint }
    its(:buildings) { is_expected.to all(be_a(DspBlueprintParser::Building)) }
    its(:buildings) { is_expected.to have_attributes(size: 37) }
  end

  describe 'new header data parsed' do
    subject { @blueprint }
    its(:author) { is_expected.to eq('LRFalk01') }
    its(:custom_version) { is_expected.to eq('1.1') }
    its(:attributes) { is_expected.to eq([':Attribute 1\\\\bait\\b']) }
    its(:description) { is_expected.to eq('Desc') }
  end
end
