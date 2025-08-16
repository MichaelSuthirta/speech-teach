# Flask
from flask import Flask, jsonify

# Numeric dependencies
import numpy as np

# Random word dependencies
import pandas as pd

# Random word generator
dictionary = (pd.read_csv("Backend\\Resource\\english Dictionary.csv")).to_dict()

index = np.random.randint(low=0, high=len(dictionary["word"]))
print(index)

chosen_word = dictionary["word"][index]
word_meaning = dictionary["def"][index]
print(chosen_word, ", definition: ", word_meaning)