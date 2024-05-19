FROM ubuntu

RUN apt-get update && apt-get install -y \
jq \
curl \
python3-dev \
python3-pillow \
python3-pip \
liblzo2-dev

ADD . /code
WORKDIR /code

RUN pip install -r requirements.txt --break-system-packages

RUN apt-get clean
RUN chmod 700 /code/batch-download.sh

# Run the app
CMD ["/code/batch-download.sh"]