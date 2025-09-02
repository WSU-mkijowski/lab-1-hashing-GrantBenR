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

def salty_hasher(init_data: DataFrame) -> tuple[DataFrame,DataFrame]:

    output_data = init_data.copy()
    solution_data = init_data.copy()
    for i in range(0, len(init_data)):
        unhashed_str = str(init_data.iloc[i, 0])
        salt = pour_the_salt(salt_length=5)
        unhashed_str = salt + unhashed_str
        hashed_str = sha256(unhashed_str.encode('utf-8')).hexdigest()
        salted_hash = salt + hashed_str
        output_data.iloc[i, 0] = f"{salted_hash}"
        solution_data.iloc[i, 0] = f"{salted_hash} - {unhashed_str}"
    hash_tuple = (output_data, solution_data)
    return hash_tuple

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
    
    hashed_data, solution_data = salty_hasher(init_data=init_data)

    hashed_data_name = "salted-data"
    solution_data_name = "salted-data-solution"

    hashed_data_path = join(getcwd(), "data", f"{hashed_data_name}.csv")
    solution_data_path = join(getcwd(), "data", f"{solution_data_name}.csv")

    hashed_data.to_csv(path_or_buf=hashed_data_path, index=False, mode="w")
    solution_data.to_csv(path_or_buf=solution_data_path, index=False, mode="w")
if __name__ == "__main__":
    main()