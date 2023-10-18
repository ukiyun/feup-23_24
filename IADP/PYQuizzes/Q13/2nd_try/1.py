def vowel_consonants(sentence):
    vowels = "aeiouAEIOU"
    count = 0

    # Split the sentence into words
    words = sentence.split()

    for word in words:
        i = 1
        while i < len(word) - 1:
            if word[i - 1] not in vowels and word[i] in vowels and word[i + 1] not in vowels:
                count += 1
            i += 1

    return count

# Test the function with your example
result = vowel_consonants('Today I will go to the movies')
print(result)  # Output should be 4
