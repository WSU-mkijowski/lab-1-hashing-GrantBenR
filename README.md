[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/SPs4PNWX)
# Lab 1 : CEG 3400 Intro to Cyber Security

## Name:

### Task 1: Hashing

**Reminder Deliverable:** Is your `salted-data.csv` in this repository?

Answer the following in this file:

* How many unique users are in the data?
> 43
* How many salts did you create?
> 1302 unique 5 digit numbers
* How many possible combinations will I need to try to figure out the secret ID
  of all students (assume I know all potential secret IDs and have your 
  `salted-data.csv`)
> 1302^2 = 1,695,204
* Instead of salts, if you were to use a nonce (unique number for each hashed
  field) how many possible combinations would I need to try?
> For a 5 digit nonce as I used, there would be 
* Given the above, if this quiz data were *actual* class data, say for example
  your final exam, how would you store this dataset?  Why?
>

```bash
#Get Unique Users
awk -F',' '{print $1}' quiz_data.csv | sort -u | wc -l
```

---

### Task 2: Crypto Mining

**Reminder Deliverable:** Is your "mining" code in this repository (`mining/`)?
**Reminder Deliverable:** Is your nonce + word combos in `coins.txt`?

Answer the following:

* Paste your ***nonce+word(s) and hash(s)*** below ( either 3x `000` hashes or 1x `0000`
hash)

```
00003a51ae2b0314b9dfb4509a0bd1d45bdef56816bf121b1c5eebd16e108cfc - 762precertified
00000c0f29545aba6a94339ac99574703ba6102fdf38950facb5dfb8da3a969b - 289sandling
```

* How many words were in your dictionary?
> 37105
* How many nonces did your code iterate over?
> 37105 (statistically unique for each word)
* What was the maximum number of hashes your code *could* compute given the above?
> 37105^2 = 1,376,781,025
* What did you think about Task 2?
> It gave me a better idea of what mining crypto-tokens involved. I wrote the python scripts because I thought it would be fun, and it really was.
* Is there a better way than brute force to attempt to get higher valued coins?
* Why or why not?
> If there was a way to tell which hashes had already been computed, you could perhaps just make the hashes with a ton of zeroes. However this would not be feasible at large scale, and you would not be able to find the original unhashed string. Therefore, I would say not.

```bash
please put any cool bash one-liners or other piped commands you
learned/struggled with for task 2 here
```

