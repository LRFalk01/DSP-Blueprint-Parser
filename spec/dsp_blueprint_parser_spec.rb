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

  describe  'area is parsed correcting' do
    subject { blueprint.areas.first }
    its(:anchor_local_offset_x) { is_expected.to be(0) }
    its(:anchor_local_offset_y) { is_expected.to be(0) }
    its(:area_segments) { is_expected.to be(200) }
    its(:height) { is_expected.to be(33) }
    its(:width) { is_expected.to be(31) }
    its(:index) { is_expected.to be(0) }
    its(:parent_index) { is_expected.to be(-1) }
    its(:tropic_anchor) { is_expected.to be(0) }
  end

  describe  'correct number of buildings parsed' do
    subject { blueprint }
    its(:buildings) { is_expected.to all(be_a(DspBlueprintParser::Building)) }
    its(:buildings) { is_expected.to have_attributes(size: 1119) }
  end

  describe  'building is parsed correcting' do
    subject { blueprint.buildings.first }
    its(:index) { is_expected.to be(0) }
    its(:area_index) { is_expected.to be(0) }
    its(:local_offset_x) { is_expected.to be_within(0.01).of(3.999) }
    its(:local_offset_y) { is_expected.to be_within(0.01).of(21) }
    its(:local_offset_z) { is_expected.to be_within(0.01).of(1) }
    its(:local_offset_x2) { is_expected.to be_within(0.01).of(3.999) }
    its(:local_offset_y2) { is_expected.to be_within(0.01).of(21) }
    its(:local_offset_z2) { is_expected.to be_within(0.01).of(1) }
    its(:yaw) { is_expected.to be_within(0.01).of(0) }
    its(:yaw2) { is_expected.to be_within(0.01).of(0) }
    its(:item_id) { is_expected.to be(2003) }
    its(:model_index) { is_expected.to be(37) }
    its(:temp_output_obj_idx) { is_expected.to be(691) }
    its(:temp_input_obj_idx) { is_expected.to be(-1) }
    its(:input_to_slot) { is_expected.to be(1) }
    its(:output_from_slot) { is_expected.to be(0) }
    its(:output_to_slot) { is_expected.to be(1) }
    its(:input_from_slot) { is_expected.to be(0) }
    its(:output_offset) { is_expected.to be(0) }
    its(:input_offset) { is_expected.to be(0) }
    its(:recipe_id) { is_expected.to be(0) }
    its(:filter_fd) { is_expected.to be(0) }
  end
end
