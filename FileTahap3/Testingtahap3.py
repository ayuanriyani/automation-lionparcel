def sort_genap_ganjil(arr):

    # pemisahan number genap dan ganjil
    genap = [x for x in arr if x % 2 == 0]
    ganjil = [x for x in arr if x % 2 != 0]

    #Noted
    # 3 % 2 = 1 (karena 3 dibagi 2, sisa 1)
    # 2 % 2 = 0 (karena 2 dibagi 2 habis tanpa sisa)
    # 5 % 2 = 1 (karena 5 dibagi 2, sisa 1)
    # 1 % 2 = 1 (karena 1 dibagi 2, sisa 1)
    # 8 % 2 = 0 (karena 8 dibagi 2 habis tanpa sisa)
    # 9 % 2 = 1 (karena 9 dibagi 2, sisa 1)
    # 6 % 2 = 0 (karena 6 dibagi 2 habis tanpa sisa)

    
    # Sort both arrays in descending order
    genap.sort(reverse=True)
    ganjil.sort(reverse=True)
    
    # Penggabungan Genap first, kedua baru Ganjil
    return genap + ganjil


# Input array
input_array = [3, 2, 5, 1, 8, 9, 6]

# Get the output from the function
output_array = sort_genap_ganjil(input_array)
print(output_array)
