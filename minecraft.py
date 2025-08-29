from hashlib import sha256
from string import ascii_letters, digits
from pandas import DataFrame, read_csv
from os import getcwd
from os.path import join, exists
import random

def get_valid_hashes(init_dict: DataFrame, hashes_to_get=5, number_length=3, min_leading_zeroes=6) -> list[str]:
    count = 0
    out_hashes = list[str]()
    while len(out_hashes) < hashes_to_get:
        character_selection = digits #+ ascii_letters
        for i in range(0, len(init_dict)):
            count += 1
            unhashed_term = str(init_dict.iloc[i,0])
            for j in range(number_length):
                unhashed_term = str(random.choice(character_selection)) + unhashed_term
            hashed_term = sha256(unhashed_term.encode('utf-8')).hexdigest()
            is_valid = True
            for k in range(min_leading_zeroes):
                if not hashed_term[k] == "0":
                    is_valid = False
            if is_valid:
                out_hashes.append(f"{hashed_term} - {unhashed_term}\n")

    print("Count: ", count)
    return out_hashes


def main():
    # Define the path of the dictionary
    input_name = "words_alpha"
    input_path = join(getcwd(), "data", f"{input_name}.csv")
    init_dict = read_csv(filepath_or_buffer=input_path)

    # Get a list of valid hashes in the format "[hash] - [nonce][word]"
    valid_hashes = get_valid_hashes(init_dict=init_dict)
    output_name = "hashes"
    output_path = join(getcwd(), "miner", f"{output_name}.csv")
    # Write to output file in the miner folder
    if not exists(output_path):
        with open(output_path, "w") as f:
            f.writelines(valid_hashes)
    else:
        with open(output_path, "a") as f:
            f.writelines(valid_hashes)

if __name__ == "__main__":
    main()