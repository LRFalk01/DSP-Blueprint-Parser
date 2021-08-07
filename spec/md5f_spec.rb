RSpec.describe DspBlueprintParser do
  it 'hash valid' do
    blueprint = File.read('spec/fixtures/blueprint.txt')
    valid = DspBlueprintParser.is_valid?(blueprint)
    expect(valid).to eq(true)
  end
end
