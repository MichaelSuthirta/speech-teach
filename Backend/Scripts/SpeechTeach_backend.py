# Flask
from flask import Flask, jsonify, request
import os

# Dependencies
import numpy as np
import pandas as pd
from transformers import WhisperForConditionalGeneration, WhisperProcessor
from pydub import AudioSegment
import string


app = Flask("__name__")

UPLOAD_FOLDER = 'Backend\\Temporary_Audio_Storage'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

dictionary = None


# Class for file
class AudioFile:
    def __init(self, fileName = '', filePath = ''):
        self.filePath = filePath
        self.fileName = fileName

    def setPath(self, path):
        self.filePath = path
    
    def getPath(self):
        return self.filePath
    
    def setName(self, name):
        self.fileName = name
    
    def getName(self):
        return self.fileName
    
    def transcribe(self):
        res = model_predict(self.filePath)
        return res

# Random word generator
def load_csv():
    global dictionary
    if(dictionary == None):
        dictionary = (pd.read_csv("Backend\\Resource\\englishDictionary.csv")).to_dict()

def pick_word():
    if(dictionary == None):
        load_csv()
        
    index = np.random.randint(low=0, high=len(dictionary["word"]))
    print(index)

    chosen_word = dictionary["word"][index]
    word_meaning = dictionary["def"][index]
    word_meaning = word_meaning.split(";")[0]

    return chosen_word, word_meaning
audioFile = AudioFile()

# Audio processing
def model_predict(filePath):
    path = "Backend\\Model"
    model = WhisperForConditionalGeneration.from_pretrained(path)
    processor = WhisperProcessor.from_pretrained(path)

    audio_file = AudioSegment.from_file(filePath).set_channels(1).set_frame_rate(16000)
    audio = (np.array(audio_file.get_array_of_samples(), dtype=np.float32))/np.iinfo(np.int16).max
    print(audio)

    #Process audio file
    proc_input = processor(audio, 
                    return_tensors="pt", 
                    truncation=False, 
                    padding="longest", 
                    return_attention_mask = True, 
                    sampling_rate = 16000)

    if(proc_input.input_features.shape[-1] < 3000):
        proc_input = processor(
            audio,
            return_tensors="pt",
            sampling_rate = 16000
        )

    result_tokens = model.generate(**(proc_input))
    print(result_tokens)
    result = processor.batch_decode(result_tokens, skip_special_tokens=True)
    print(result[0])

    return result[0]

def assessAudio(actualWord, transcribedWord):
    cleanInput = ''.join(char for char in transcribedWord if char not in string.punctuation)
    cleanActual = ''.join(char for char in actualWord if char not in string.punctuation)

    if(cleanInput.lower() == cleanActual.lower()):
        return 1
    return 0

# Routes
@app.route("/")
def print_status():
    return "Server on."

@app.route("/word", methods=["GET"])
def choose_word():
    word, definition = pick_word()
    return jsonify({'Word': word, 'Definition':definition})


@app.route("/assess", methods=["POST"])
def processAudio():
    if 'file' not in request.files:
        return jsonify({'error' : 'File not found'});400
    
    file = request.files['file']
    if file.filename == '':
        return jsonify({'error' : 'File name is empty'});400
    
    audioFile.setName(file.filename)
    audioFile.setPath(os.path.join(app.config['UPLOAD_FOLDER'], audioFile.getName()))
    file.save(audioFile.getPath())

    actualWord = request.form.to_dict()['actualWord']

    transcribeResult = audioFile.transcribe()
    correctness = assessAudio(actualWord, transcribeResult)
    print(actualWord)

    if(os.path.exists(audioFile.getPath())):
        os.remove(audioFile.getPath())
    else:
        print(f"File {audioFile.getPath()} isn't in the directory")

    return jsonify({
        'Result' : transcribeResult,
        'Actual Word' : actualWord,
        'Assessment Result' : correctness
    })

if __name__ == "__main__":
    app.run() #Debug is true for deployment