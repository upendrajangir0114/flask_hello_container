FROM python:3.7
RUN useradd -ms /bin/bash celebal
USER celebal

RUN apk add openssh \
     && echo "root:Docker!" | chpasswd
COPY sshd_config /etc/ssh/
RUN /usr/sbin/sshd


WORKDIR /home/celebal/app

ADD ./requirements.txt /home/celebal/app
RUN pip install -r requirements.txt

ADD . /home/celebal/app

EXPOSE 5000 2222
CMD ["python", "/home/celebal/app/app.py"]