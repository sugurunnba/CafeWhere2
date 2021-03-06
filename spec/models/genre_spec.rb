require 'rails_helper'
RSpec.describe 'Genreモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    # let(:user) { FactoryBot.create(:user) }
    let(:genre) { FactoryBot.create(:genre) }
    # it 'emailが空だとNG' do
    #   genre.email = ''
    #   expect(genre.valid?).to be false
    # end
    it 'nameが空だとNG' do
      genre.name = ''
      expect(genre.valid?).to be false
    end
    it 'nameが15文字以上だとNG' do
      genre.name = Faker::Lorem.characters(number: 16)
      expect(genre.valid?).to be false
    end
  end
end
