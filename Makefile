NAME	=	inception
AUTHOR	=	absalhi

GREEN	=	'\033[32m'
RED		=	'\033[31m'
NC		=	'\033[0m'

include srcs/.env
export $$(shell grep -v '^#' srcs/.env | xargs)

all		:	$(NAME)

$(NAME)	:	chown
			@echo $(GREEN)"Building containers..."$(NC)
			@if [ ! -d $(BASEDIR)/ ]; then \
				echo $(RED)"No volumes found, creating..."$(NC); \
				make mkvol; \
				echo $(GREEN)"Volumes created."$(NC); \
			fi
			@if [ ! -f $(BASEDIR)/.setup ]; then \
				echo $(RED)"Hosts not set, setting up..."$(NC); \
				echo "127.0.0.1 $(AUTHOR).42.fr" >> /etc/hosts; \
				touch $(BASEDIR)/.setup; \
				echo $(GREEN)"Hosts set."$(NC); \
			fi
			@docker-compose -f srcs/docker-compose.yml up --build -d
			@echo $(GREEN)"Containers built."$(NC)

clean	:
			@echo $(RED)"Bringing containers down and removing images..."$(NC)
			@docker-compose -f srcs/docker-compose.yml down -v --rmi all --remove-orphans
			@echo $(GREEN)"Containers down."$(NC)

fclean	:	clean
			@echo $(RED)"Removing volumes..."$(NC)
			@rm -rf $(BASEDIR)/
			@docker volume prune --force
			@echo $(GREEN)"Volumes removed."$(NC)
			@echo $(RED)"Removing containers..."$(NC)
			@docker system prune --volumes --all --force
			@echo $(GREEN)"Containers removed."$(NC)
			@echo $(RED)"Removing networks..."$(NC)
			@docker network prune --force
			@echo $(GREEN)"Networks removed."$(NC)

re		:	fclean all

restart	:
			@echo $(GREEN)"Restarting containers..."$(NC)
			@docker-compose -f srcs/docker-compose.yml restart
			@echo $(GREEN)"Containers restarted."$(NC)

mkvol	:
			@mkdir -p $(BASEDIR)/wordpress $(BASEDIR)/mariadb
			@chown -R $(AUTHOR):$(AUTHOR) $(BASEDIR)/*
			@chown -R $(AUTHOR):$(AUTHOR) $(BASEDIR)/.*

logs	:
			@docker-compose -f srcs/docker-compose.yml logs -f

ps		:
			@docker-compose -f srcs/docker-compose.yml ps

chown	:
			@chown -R $(AUTHOR):$(AUTHOR) ./*
			@chown -R $(AUTHOR):$(AUTHOR) ./.*

.PHONY	:	all clean fclean re restart mkvol logs ps chown