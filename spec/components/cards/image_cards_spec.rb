require 'rails_helper'

RSpec.describe 'Image cards component', type: :view do
  describe 'Checking image cards component structure' do
    it 'It have image src section' do
      render 'components/cards/image_cards', img_src: 'test_url'
      expect(rendered).to match /<img class=\"card-img-top\" src=\"test_url\" alt=\"Card image cap\">\n/
    end

    it 'It have comment section' do
      render 'components/cards/image_cards', img_src: 'test_url', comment: 'test_comment'
      expect(rendered).to match /<p class=\"card-text\">test_comment<\/p>/
    end

    it 'It have header section' do
      render 'components/cards/image_cards', img_src: 'test_url', heading: 'test_heading'
      expect(rendered).to match /<h5 class=\"card-title\">test_heading<\/h5>/
    end
  end

  describe 'Redering image card with no image src' do
    it 'Returns an empty html' do
      render 'components/cards/image_cards'
      expect(rendered).to be_empty
    end
  end
end
