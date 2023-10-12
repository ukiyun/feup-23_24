def dechours_to_hms(numbers):
    number = str(numbers)
    divided = number.split('.')
    hours = divided[0] + ' hours, '
    number2 = str((float('0.'+ divided[1])* 60))
    divided2 = number2.split('.')
    minutes = divided2[0] + ' minutes, '
    number3 = str(int((float('0.' + divided2[1])*3600/60)))
    seconds = number3 + ' seconds'
    result = hours + minutes + seconds
    return result    
    





print(dechours_to_hms(24.5))
