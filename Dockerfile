FROM debian

# install the necessary software
RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
    ca-certificates \
    curl \
    python3-numpy \
    python3-pil \
    python3-pip

# do all the installation in /tmp directory
WORKDIR /tmp

# set the version using a variable
ARG RTIMULIB_VERSION=7.2.1-3

# get all th required libraries
RUN curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/librtimulib-dev_${RTIMULIB_VERSION}_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/librtimulib-utils_${RTIMULIB_VERSION}_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/librtimulib7_${RTIMULIB_VERSION}_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/python3-rtimulib_${RTIMULIB_VERSION}_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/p/python-sense-hat/python3-sense-hat_2.2.0-1_armhf.deb

# install the required libraries
RUN dpkg -i \
    librtimulib-dev_${RTIMULIB_VERSION}_armhf.deb \
    librtimulib-utils_${RTIMULIB_VERSION}_armhf.deb \
    librtimulib7_${RTIMULIB_VERSION}_armhf.deb \
    python3-rtimulib_${RTIMULIB_VERSION}_armhf.deb \
    python3-sense-hat_2.2.0-1_armhf.deb

# cleanups
RUN rm -f /tmp/*.deb \
   && apt-get clean \ 
   && rm -rf /var/lib/apt/lists/*


COPY ./requirements.txt /
COPY ./sensehat-exporter.py /
RUN pip3 install -r /requirements.txt


CMD [ "python3", "/sensehat-exporter.py", "--orientation"]
