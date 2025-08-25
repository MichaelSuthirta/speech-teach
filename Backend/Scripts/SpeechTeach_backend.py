# Flask
from flask import Flask, jsonify, request
import json
import os
from werkzeug.utils import secure_filename

# Dependencies
import numpy as np
import pandas as pd
from transformers import WhisperForConditionalGeneration, WhisperProcessor
from pydub import AudioSegment


app = Flask("__name__")
UPLOAD_FOLDER = 'Backend\\Temporary Audio Storage'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

dictionary = None
# filePath = None


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

audioFile = AudioFile()

# Transcriber

def model_predict(fileName):
    path = "Backend\\Model"
    model = WhisperForConditionalGeneration.from_pretrained(path)
    processor = WhisperProcessor.from_pretrained(path)

    audio_file = AudioSegment.from_file(fileName).set_channels(1).set_frame_rate(16000)
    audio = (np.array(audio_file.get_array_of_samples(), dtype=np.float32))/np.iinfo(np.int16).max
    print(audio)

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

    return result[0]

# Routes

@app.route("/")
def print_status():
    return "Server on."

@app.route("/word", methods=["GET"])
def choose_word():
    word, definition = pick_word()
    return jsonify({'Word': word, 'Definition':definition})


@app.route("/assess", methods=["GET", "POST"])
def transcribeAudio():
    global response

    if(request.method == "POST"):
        # data = request.data
        # data = json.loads(data.decode("utf-8"))
        # filePath = data["filePath"]
        # return ""
        # global filePath

        if 'file' not in request.files:
            return jsonify({'error' : 'File not found'});400
        
        file = request.files['file']
        if file.filename == '':
            return jsonify({'error' : 'File name is empty'});400
        
        audioFile.setName(file.filename)
        
        filePath = os.path.join(app.config['UPLOAD_FOLDER'], audioFile.getName())
        audioFile.setPath(filePath)

        file.save(filePath)

        return ''

    else:
        # word = model_predict(filePath)
        # return jsonify({"Transcription" : word})
        return jsonify({"Path" : audioFile.getName()})

if __name__ == "__main__":
    app.run(debug="True") 