FROM python:3.11
WORKDIR /SpeechTeach_Backend

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y ffmpeg

COPY . .

CMD ["python", "SpeechTeach_backend.py"]