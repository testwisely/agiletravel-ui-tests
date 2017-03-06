require 'test/unit'
include Test::Unit::Assertions

@vowels = nil;

step 'Vowels in English language are <vowels>.' do |vowels|
   @vowels = vowels.scan(/./);
end

step 'The word <word> has <count> vowels.' do |word, expectedCount|
  assert_equal(expectedCount.to_i, count_vowels(word))
end

step 'Almost all words have vowels <table>' do |wordsTable|
  wordsTable.rows().each do |row|
   word = row['Word'];
   expectedCount = row['Vowel Count'].to_i
   actualCount = count_vowels(word)
   assert_equal(expectedCount, actualCount)
 end
end

def count_vowels(string)
  string.count(@vowels.to_s)
end
