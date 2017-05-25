require_relative './../spec_helper.rb'

describe InterpretService do
  before do
    @company = create(:company)
  end

  describe '#list' do
    it 'list zero faqs, return dont found  message' do
      response = InterpretService.call('list', {})
      expect(response).to match('not found')
    end

    it 'list with two faqs, find questions and answer in response' do
      faq1 = create(:faq, company: @company)
      faq2 = create(:faq, company: @company)

      response = InterpretService.call('list', {})

      expect(response).to match(faq1.question)
      expect(response).to match(faq1.answer)

      expect(response).to match(faq2.question)
      expect(response).to match(faq2.answer)
    end
  end

    describe '#search' do
      it 'search with empty query, return dont find message' do
        response = InterpretService.call('search', {'query': ''})
        expect(response).to match('not found')
      end

      it 'search with valid query, find question and answer in response' do
        faq = create(:faq, company: @company)

        response = InterpretService.call('search', {'query' => faq.question.split(" ").sample})

        expect(response).to match(faq.question)
        expect(response).to match(faq.answer)
      end
    end

    describe '#search by category' do
      it 'search with invalid hashtag, return dont find message' do
        response = InterpretService.call('search_by_hashtag', {"query": ''})
        expect(response).to match('not found')
      end

      it 'search with valid hashtag, find question and answer in response' do
        faq = create(:faq, company: @company)
        hashtag = create(:hashtag, company: @companhy)
        create(:faq_hashtag, faq: faq, hashtag: hashtag)

        response = InterpretService.call('search_by_hashtag', {"query" => hashtag.name})

        expect(response).to match(faq.question)
        expect(response).to match(faq.answer)
      end
    end

    describe '#create' do
      before do
        @question = FFaker::Lorem.sentence
        @answer = FFaker::Lorem.sentence
        @hashtags = '#{FFaker::Lorem.word}, #{FFaker::Lorem.word}'
      end

      it 'Create without params, receive an error' do
        response = InterpretService.call('create', {'question-original' => @question, 'answer-original' => @answer})
        expect(response).to match('It must have a Hashtag')
      end

      it 'Create with valid params, receive a success message' do
        response = InterpretService.call('create', {'question-original' => @question, 'answer-original' => @answer, "hashtags-original" => @hashtags})
        expect(response).to match('It has been created successfully')
      end

      it 'Created with valid params, find question and answer in database' do
        response = InterpretService.call('create', {'question-original' => @question, 'answer-original' => @answer})
        expect(Faq.last.question).to match(@question)
        expect(Faq.last.answer).to match(@answer)
      end

      it 'Created with valid params, hashtags are created' do
        response = InterpretService.call('create', {'question-original' => @question, 'answer-original' => @answer, "hashtags-original" => @hashtags})
        expect(@hashtags.split(/[\s,]+/).first).to match(Hashtag.first.name)
        expect(@hashtags.split(/[\s,]+/).last).to match(Hashtag.last.name)
      end
    end

    describe '#remove' do
      it 'Remove valid ID, remove Faq' do
        faq = create(:faq, company: @company)
        response = InterpretService.call('remove', {'id' => faq.id})
        expect(response).to match('It has been deleted successfully')

      end

      it 'Remove invalid ID, receive error message' do
        response = InterpretService.call('remove', {'id' => rand(1..9999)})
        expect(response).to match('Invalid question, please verify the ID')
      end
    end

end
