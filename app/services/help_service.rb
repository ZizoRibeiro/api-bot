class HelpService
  def self.call
    response = "*I know what to do :raised_hands:* \n\n"
    response += "*help*\n"
    response += ">The list of commands that I know about\n\n"
    response += "Add to the FAQ*\n"
    response += ">Add a new question to the FAQ\n\n"
    response += "*Delete ID*\n"
    response += ">Remove one question based on its ID\n\n"
    response += "*What do you know about X*\n"
    response += ">Search for this word in the list of questions and answers\n\n"
    response += "*Search for the hashtag X*\n"
    response += ">List of questions and answers with that hashtag\n\n"
    response += "*Questions and answers*\n"
    response += ">Show the list of the questions and answers\n\n"
    response
  end
end
