require_relative './../../spec_helper.rb'

describe FaqModule::CreateService do
  before do
    @company = create(:company)

    @question = FFaker::Lorem.sentence
    @answer = FFaker::Lorem.sentence
    @hashtag = "#{FFaker::Lorem.word}, #{FFaker::Lorem.word}"
  end

  describe '#call' do
    it 'Call without hashtag params, it will receive a error' do
      @createService = Faqmodule::CreateService.new({'question.original' => @question, 'answer.original' => @answer})

      response = @createService.call()
      expect(response).to match('It must have a Hashtag')
    end

    it 'Call with valid params, receive success message' do
      @createService = FaqModule::CreateService.new({'question.original' => @question, 'answer.original' => @answer, 'hashtag.original' => @hashtags})

      response = @createService.call()
      expect(response).to match('It has been created successfully!')
    end

    it 'Call with valid params, find question and answer in the database' do
      @createService = FaqModule::CreateService.new({'question.original' => @question, 'answer.original' => @answer, 'hashtag.original' => @hashtags})

      response = @createService.call()
      expect(Faq.last.question).to eq(@question)
      expect(Faq.last.answer).to eq(@answer)
    end

    it 'Call with valid params, hashtags are created' do
      @createService = FaqModule::CreateService.new({'question.original' => @question, 'answer.original' => @answer, 'hashtags.original' => @hashtags })

      response = @createService.call()
      expect(@hashtags.split(/[\s,]+/).first).to eq(Hashtag.first.name)
      expect(@hashtags.split(/[\s,]+/).last).to eq(Hashtag.last.name)
    end
  end
end
