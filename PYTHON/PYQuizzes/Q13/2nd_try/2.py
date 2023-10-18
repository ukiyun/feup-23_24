def lastfirstname(sentence):
    sen = list(sentence.split(" "))
    sen.reverse()
    sent = str(sen[0])+', '
    sen.pop(0)
    sen.reverse()
    sent = sent + ' '.join(sen)
    
    return sent
        
    
    
    
print(lastfirstname('Carlos Alberto Fonseca'))
