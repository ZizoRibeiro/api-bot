module FaqModule
  class RemoveService
    def initialize(params)
      @company = Company.last
      @params = params
      @id = params["id"]
    end

    def call
      faq = @company.faqs.where(id: @id).last
      return "Invalid question, please verify the ID" if faq == nil

      Faq.transaction do
        faq.hashtags.each do |h|
          if h.faqs.count <= 1
            h.delete
          end
        end
        faq.delete
        "It has been deleted successfully"
      end
    end
  end

end