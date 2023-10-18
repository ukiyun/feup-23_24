

def isvowel(character):
    if (character.lower() == 'a' or character.lower() == 'e' or character.lower() == 'i' or character.lower() == 'o' or character.lower() == 'u'):
        return True
    else:
        return False
    
    
print(isvowel('a'))
print(isvowel('c'))
print(isvowel('E'))
