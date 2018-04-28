FROM nginx:latest
MAINTAINER Gabe Leonard "gabe@databaseguy.com"

RUN apt-get update
RUN apt-get install sudo -y
# Since there isn't a release for stretch, we don't need lsb-release, and just use jessie.
#RUN apt-get install lsb-release -y
RUN apt-get install curl -y
RUN apt-get install gnupg2 -y

# Environment variables like this are tricky, so we manually add "gcsfuse-jessie" into the command.
#RUN export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s`
#RUN export GCSFUSE_REPO=gcsfuse-jessie
RUN echo "deb http://packages.cloud.google.com/apt gcsfuse-jessie main" | sudo tee /etc/apt/sources.list.d/gcsfuse.list

RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

RUN sudo apt-get update
RUN sudo apt-get install gcsfuse -y

#COPY . /usr/local
COPY webcomic-key.json /usr/local/bin/webcomic-key.json
COPY run.sh /usr/local/bin/run.sh

RUN chmod 755 /usr/local/bin/run.sh

#ENV GOOGLE_APPLICATION_CREDENTIALS=/usr/local/bin/webcomic-key.json

ENTRYPOINT ["/usr/local/bin/run.sh"]
CMD ["nginx", "-g", "daemon off;"]