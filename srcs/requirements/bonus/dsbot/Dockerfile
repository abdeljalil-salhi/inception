FROM	debian:buster

RUN		apt update -y && apt upgrade -y \
		&& apt install -y python3 python3-pip \
		&& rm -rf /var/lib/apt/lists/* \
		&& mkdir /app

COPY	app/* app/

CMD		["pip3", "-r", "requirements.txt", "&&", "python3", "bot.py"]