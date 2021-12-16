FROM protik77/python3-sensehat

WORKDIR /
RUN apt update && apt install -y python3-pip


COPY ./requirements.txt /
COPY ./sensehat-exporter.py /
RUN pip3 install -r /requirements.txt


CMD [ "python3", "/sensehat-exporter.py", "--orientation"]
