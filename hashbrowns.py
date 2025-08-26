from hashlib import sha256
from string import ascii_letters, digits
from pandas import DataFrame, read_csv
from os import getcwd
from os.path import join
import random

def low_sodium_hasher(init_data: DataFrame) -> list[str]:

    hashes = list[str]()
    for i in range(0, len(init_data)):
        unhashed_str = str(init_data.iloc[i, 0])
        hashed_str = sha256(unhashed_str.encode('utf-8')).hexdigest()
        hashes.append(hashed_str)
    return hashes
def salty_hasher(init_data: DataFrame) -> list[str]:
    salty_hashes = list[str]()
    for i in range(0, len(init_data)):
        unhashed_str = str(init_data.iloc[i, 0])
        salt = pour_the_salt(salt_length=5)
        unhashed_str = salt + unhashed_str
        hashed_str = sha256(unhashed_str.encode('utf-8')).hexdigest()
        salted_str = salt + hashed_str
        salty_hashes.append(salted_str)
    return salty_hashes
def pour_the_salt(salt_length: 5) -> str:
    character_selection = ascii_letters + digits
    salt_str = ""
    for i in range(salt_length):
        salt_str = salt_str + str(random.choice(character_selection))
    return salt_str

def main():
    input_name = "quiz_data"
    input_path = join(getcwd(), "data", f"{input_name}.csv")
    init_data = read_csv(filepath_or_buffer=input_path)
    hashes = salty_hasher(init_data=init_data)
    output_data = init_data.copy()
    for i in range(len(hashes)):
        output_data.iloc[i, 0] = hashes[i]
    print(output_data)
    output_name = "salted-data"
    output_path = join(getcwd(), "data", f"{output_name}.csv")
    output_data.to_csv(path_or_buf=output_path)
if __name__ == "__main__":
    main()