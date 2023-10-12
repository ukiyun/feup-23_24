def words_start_vowel(string):
    count = 0
    vowels = 'aeiou'
    sentence = string.split()
    for words in sentence:
        if (words[0].lower() in vowels):
            count +=1

    
    return count
    
    
    
print(words_start_vowel('oday I will go to the movies'))
