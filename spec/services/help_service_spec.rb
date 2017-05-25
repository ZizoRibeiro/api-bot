require_relative './../spec_helper.rb'

describe HelpService do
  describe '#call' do
    it 'Response has the main commands' do
      response = HelpService.call()
      expect(response).to match('help')
      expect(response).to match('Add a new question to the FAQ')
      expect(response).to match('Delete ID')
      expect(response).to match('What do you know about X')
      expect(response).to match('Search for the hashtag X')
      expect(response).to match('Questions and answers')
    end
  end
end
