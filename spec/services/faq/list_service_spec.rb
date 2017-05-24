require_relative './../../spec_helper.rb'

describe FaqModule::ListService do
  before do
    @company = create(:company)
  end

  describe '#call' do
    it 'call with a list of commands: when is zero faqs, return I cant find the message' do
      @listService = FaqModule::ListService.new({}, 'list')

      response = @listService.call()
      expect(response).to eq('search not found')
    end

    it 'list command call with two faqs, find questions and answers in response' do
      @listService = FaqModule::ListService.new({}, 'list')

      faq1 = create(:faq, company: @company)
      faq2 = create(:faq, company: @company)

      response = @listService.call()

      expect(response).to eq(faq1.question)
      expect(response).to eq(faq1.answer)

      expect(response).to eq(faq2.question)
      expect(response).to eq(faq2.answer)
    end

    it 'call with search command: query empty, return I cant find the message' do
      @listService = FaqModule::ListService.new({'query' => ''}, 'search')

      response = @listService.call()
      expect(response).to eq('search not found')
    end

    it 'call with search command: valid query, find question and answer in response' do
      faq = create(:faq, company: @company)

      @listService = FaqModule::ListService.new({'query' => faq.question.split(" ").sample}, 'search')

      response = @listService.call()

      expect(response).to eq(faq.question)
      expect(response).to eq(faq.answer)
    end

    it 'call with search_by_hashtag command: invalid hashtag, return I dont find the message' do
      @listService = FaqModule::ListService.new({'query' => ''}, 'search_by_hashtag')

      response = @listService.call()
      expect(response).to eq('search not found')
    end

    it 'call with search_by_hashtag command: valid hashtag, find question and answer in response' do
      faq = create(:faq, company: @company)
      hashtag = create(:hashtag, company: @company)
      create(:faq_hashtag, faq: faq, hashtag: hashtag)

      @listService = FaqModule::ListService.new('query' => hashtag.name), 'search_by_hashtag'

      response = @listService.call()

      expect(response).to eq(faq.question)
      expect(response).to eq(faq.answer)
    end
  end
end
