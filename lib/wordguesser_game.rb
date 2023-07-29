class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.
  attr_reader :word, :guesses, :wrong_guesses

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = '-' * @word.length
  end

  def word_with_guesses
    @word_with_guesses
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://random@word.saasbook.info/RandomWord')
    Net::HTTP.new('random@word.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

  def check_win_or_lose
    
    return :lose if @wrong_guesses.length >= 7
    
    return :win if @word == @word_with_guesses

    :play
 
  end

  def replace_word_with_guesses(letter)
    indices = []
    @word.each_char.with_index do |char, index|
      indices << index if char == letter
    end
    indices.each do |index|
      @word_with_guesses[index] = letter
    end
  end

  def guess(letter)

    # long code version by me
    # if letter.nil? || letter.empty? || !letter.match?(/[a-zA-Z]/)
    #   raise ArgumentError
    # end
    raise ArgumentError unless !letter.nil? && letter.match?(/[a-zA-Z]/) # shortened by ChatGPT and added nil case by me

    letter = letter.downcase

    return false if @guesses.include?(letter) || @wrong_guesses.include?(letter) # suggested by ChatGPT, one-lined by me


    if @word.include?(letter)
      # if !guesses.include?(letter)
        @guesses << letter
        replace_word_with_guesses(letter)
        # return true
      # else
      #   return false
      # end
    else
      # if !wrong_guesses.include?(letter)
        @wrong_guesses << letter
        # return true
      # else
      #   return false
      # end
    end
    # return false
  end 


end
