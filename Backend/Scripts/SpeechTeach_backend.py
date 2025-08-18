# Flask
from flask import Flask, jsonify

# Dependencies
import numpy as np
import pandas as pd

app = Flask("__name__")

dictionary = None

# Random word generator
def load_csv():
    global dictionary
    if(dictionary == None):
        dictionary = (pd.read_csv("Backend\\Resource\\english Dictionary.csv")).to_dict()

def pick_word():
    if(dictionary == None):
        load_csv()
        
    index = np.random.randint(low=0, high=len(dictionary["word"]))
    print(index)

    chosen_word = dictionary["word"][index]
    word_meaning = dictionary["def"][index]
    word_meaning = word_meaning.split(";")[0]

    return chosen_word, word_meaning

# Routes

@app.route("/")
def print_status():
    return "Server on."

@app.route("/word", methods=["GET"])
def choose_word():
    word, definition = pick_word()
    return jsonify({'Word': word, 'Definition':definition})

if __name__ == "__main__":
    app.run(debug="True") 