require_relative './../spec_helper.rb'

describe HelpService do
  describe '#call' do
    it 'Response has the main commands' do
      response = Helpservice.call()
      expect(response).to eq('help')
      expect(response).to eq('Add a new faq')
      expect(response).to eq('Delete ID')
      expect(response).to eq('What do you know about X')
      expect(response).to eq('Search the hashtag X')
      expect(response).to eq('Questions and Answers')
    end
  end
end
