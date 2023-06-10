FROM	debian:buster

RUN		apt update -y && apt upgrade -y \
		&& apt install -y python3 python3-pip \
		&& rm -rf /var/lib/apt/lists/* \
		&& mkdir /app

COPY	app/* app/
RUN		pip3 install -r app/requirements.txt

CMD		["sh", "-c", "python3 app/bot.py"]