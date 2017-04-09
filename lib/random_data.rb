# RandomData is a module,to keep common functions organized
# use as mixins to add functions to multiple class
# modules cannot be instatiated or inherit like classes
module RandomData

  # define random_paragraph
  # set sentences to an array,
  # create 4-6 random sentences and append to the array
  # join is called to combine each sentence and a space to make a paragraph
  def self.random_paragraph
    sentences = []
    rand(4..6).times do
      sentences << random_sentence
    end

    sentences.join(" ")
  end


  # create sentence with random number of words
  # capitalize it and append a period
  def self.random_sentence
    strings = []
    rand(3..8).times do
      strings << random_word
    end

    sentence = strings.join(" ")
    sentence.capitalize << "."
  end

  # define random word...set letters to array of letters a-z using to_a
  # call shuffle! on letters IN PLACE. (using without bang! would produce array
  # Join the zero to nth item in letters
  # nth is the result of rand(3..8) which returns random nbr >=3 and <8
  def self.random_word
    letters = ('a'..'z').to_a
    letters.shuffle!
    letters[0,rand(3..8)].join
  end
end
