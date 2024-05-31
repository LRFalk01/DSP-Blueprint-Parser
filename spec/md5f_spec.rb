RSpec.describe DspBlueprintParser do
  it 'validates factory blueprint hashes' do
    blueprint = File.read('spec/fixtures/blueprint.txt')
    valid = DspBlueprintParser.is_valid?(blueprint)
    expect(valid).to eq(true)
  end

  it 'validates sphere blueprint hashes' do
    blueprint = File.read('spec/fixtures/sphere_blueprint.txt')
    valid = DspBlueprintParser.is_valid?(blueprint)
    expect(valid).to eq(true)
  end
end
