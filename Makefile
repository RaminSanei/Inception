COLOR_RESET = \033[0m
COLOR_GREEN = \033[32m
COLOR_RED = \033[31m
COLOR_YELLOW = \033[33m
COLOR_BLUE = \033[34m

SRC_DIR = srcs
DATA_DIR = /home/$(USER)/data
DB_DATA = $(DATA_DIR)/mariadb
WP_DATA = $(DATA_DIR)/wordpress
ENV_FILE = $(SRC_DIR)/.env
COMPOSE_FILE = $(SRC_DIR)/docker-compose.yml
DOCKER_COMPOSE = docker-compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE)

# Ensure data directories exist
$(DB_DATA) $(WP_DATA):
	mkdir -p $@

.PHONY: build up down start stop clean prune re

build:
	@echo "$(COLOR_BLUE)Building Docker images...$(COLOR_RESET)"
	$(DOCKER_COMPOSE) build
	@echo "$(COLOR_GREEN)Build completed successfully!$(COLOR_RESET)"

up: $(DB_DATA) $(WP_DATA)
	@echo "$(COLOR_BLUE)Starting services...$(COLOR_RESET)"
	$(DOCKER_COMPOSE) up -d --force-recreate --build
	@echo "$(COLOR_GREEN)Services started successfully!$(COLOR_RESET)"

down:
	@echo "$(COLOR_YELLOW)Stopping and removing services...$(COLOR_RESET)"
	$(DOCKER_COMPOSE) down
	@echo "$(COLOR_GREEN)Services stopped successfully!$(COLOR_RESET)"

start:
	@echo "$(COLOR_BLUE)Starting containers...$(COLOR_RESET)"
	$(DOCKER_COMPOSE) start
	@echo "$(COLOR_GREEN)Containers started successfully!$(COLOR_RESET)"

stop:
	@echo "$(COLOR_BLUE)Stopping containers...$(COLOR_RESET)"
	$(DOCKER_COMPOSE) stop
	@echo "$(COLOR_GREEN)Containers stopped successfully!$(COLOR_RESET)"

clean:
	@echo "$(YELLOW)[Clean] Removing containers, images, volumes...$(RESET)"
	-docker stop $$(docker ps -qa)
	-docker rm $$(docker ps -qa)
	-docker rmi -f $$(docker images -qa)
	-docker volume prune -f
	-docker network prune -f
	rm -rf $(DB_DATA)/* $(WP_DATA)/*
	@echo "$(GREEN)[Clean] Done.$(RESET)"

prune: clean
	@echo "$(YELLOW)[Prune] Deep system cleanup...$(RESET)"
	docker system prune -a --volumes -f
	@echo "$(GREEN)[Prune] Done.$(RESET)"

re: clean up
	@echo "$(BLUE)[Re] Rebuilding and restarting...$(RESET)"