all	:	re

up	:
		@docker-compose -f srcs/docker-compose.yml up --build -d

down	:
		@docker-compose -f srcs/docker-compose.yml down

clean	:	down
		@rm -rf volumes/mariadb/*
		@docker-compose -f srcs/docker-compose.yml rm -v

fclean	:	clean
		@docker system prune -f

re	:	fclean up

.PHONY	:	all up down clean fclean re

