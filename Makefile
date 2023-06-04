all		:	re

up		:	chown
			@mkdir -p /home/absalhi/volumes/wordpress/ /home/absalhi/volumes/mariadb/
			@docker-compose -f srcs/docker-compose.yml up --build -d

down	:
			@docker-compose -f srcs/docker-compose.yml down

clean	:	down
			@rm -rf /home/absalhi/volumes/
			@docker-compose -f srcs/docker-compose.yml rm -v

fclean	:	clean
			@docker network prune -f
			@docker system prune -f

re		:	fclean up

clear_volumes	:
			@docker volume rm mariadb wordpress

chown	:
			@chown -R absalhi:absalhi ./*
			@chown -R absalhi:absalhi ./.*

nginx	:
			@docker build -t nginx ./srcs/requirments/nginx/
			@docker run -it --rm -p 80:80 -p 443:443 nginx -e ALPINE_VERSION=3.18.0

.PHONY	:	all up down clean fclean clear_volumes re chown nginx
