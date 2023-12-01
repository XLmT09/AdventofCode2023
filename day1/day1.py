total = 0
numbers = {"one":1 ,"two":2, "three":3, "four":4, "five":5, "six":6, "seven":7, "eight":8, "nine":9}

def is_string_subset(s, numbers_dict):
    substrings = [s[i:j] for i in range(len(s)) for j in range(i + 1, len(s) + 1)]

    for substring in substrings:
        if substring in numbers_dict:
            return numbers_dict[substring]
    return None

with open("scripts.txt") as file:
    for line in file:
        final_num = 0
        num_string_front = ""
        num_string_back = ""

        for char in line:
            num_string_front += char

            if res := is_string_subset(num_string_front, numbers):
                final_num += res * 10
                break

            if char.isdigit():
                final_num += (int(char) * 10)
                break
            
        
        for char in line[::-1]:
            num_string_back = char + num_string_back

            if res := is_string_subset(num_string_back, numbers):
                final_num += res
                break

            if char.isdigit():
                final_num += int(char)
                break
        
        total += final_num
    
print(total)