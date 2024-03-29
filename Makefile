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
				echo "127.0.0.1	localhost" > /etc/hosts; \
				echo "127.0.1.1	$(AUTHOR)42" >> /etc/hosts; \
				echo "127.0.0.1	$(AUTHOR).42.fr" >> /etc/hosts; \
				echo "::1		localhost ip6-localhost ip6-loopback" >> /etc/hosts; \
				echo "ff02::1		ip6-allnodes" >> /etc/hosts; \
				echo "ff02::2		ip6-allrouters" >> /etc/hosts; \
				touch $(BASEDIR)/.setup; \
				echo $(GREEN)"Hosts set."$(NC); \
			fi
			@docker-compose -f srcs/docker-compose.yml up --build -d
			@echo $(GREEN)"Containers built."$(NC)

prod	:	$(NAME)
			@echo $(GREEN)"Deleting intermediate resources..."$(NC)
			@docker system prune --force
			@echo $(GREEN)"Intermediate resources deleted."$(NC)

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
			@mkdir -p $(BASEDIR)/wordpress $(BASEDIR)/mariadb $(BASEDIR)/website
			@chown -R $(AUTHOR):$(AUTHOR) $(BASEDIR)/*
			@chown -R $(AUTHOR):$(AUTHOR) $(BASEDIR)/.*

logs	:
			@docker-compose -f srcs/docker-compose.yml logs -f

ps		:
			@echo "\n"$(GREEN)"Containers status:"$(NC)
			@docker-compose -f srcs/docker-compose.yml ps
			@echo "\n"
			@docker ps -a
			@echo "\n"$(GREEN)"Volumes status:"$(NC)
			@docker volume ls
			@echo "\n"$(GREEN)"Networks status:"$(NC)
			@docker network ls
			@echo "\n"$(GREEN)"Images status:"$(NC)
			@docker images
			@echo "\n"$(GREEN)"Hosts status:"$(NC)
			@cat /etc/hosts

chown	:
			@chown -R $(AUTHOR):$(AUTHOR) ./*
			@chown -R $(AUTHOR):$(AUTHOR) ./.*

.PHONY	:	all prod clean fclean re restart mkvol logs ps chown