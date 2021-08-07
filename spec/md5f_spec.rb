RSpec.describe DspBlueprintParser do
  it 'correct number of areas parsed' do
    blueprint = File.read('spec/fixtures/blueprint.txt')
    valid = DspBlueprintParser.valid?(blueprint)

    expect(valid).to eq(true)
  end
end
