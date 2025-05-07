
# DOCKER_COMPOSE = docker-compose -f srcs/docker-compose.yml
# VOLUME_DIR = /home/ssanei/data

# all: up

# # Target to create necessary directories
# create_dirs:
# 	mkdir -p ${VOLUME_DIR}/mariadb
# 	mkdir -p ${VOLUME_DIR}/wordpress

# # build: create_dirs
# 	# ${DOCKER_COMPOSE} build

# build:
# 	${DOCKER_COMPOSE} build

# # up: build
# # 	${DOCKER_COMPOSE} up -d
# up: create_dirs build
# 	${DOCKER_COMPOSE} up -d

# down:
# 	${DOCKER_COMPOSE} down

# stop:
# 	${DOCKER_COMPOSE} stop

# start:
# 	${DOCKER_COMPOSE} start

# clean:
# 	docker rm -f mariadb wordpress nginx
# 	docker rmi -f mariadb wordpress nginx
# 	docker volume rm $(shell docker volume ls -q)
# 	docker system prune -a -f

# re: clean all

# restart:
# 	${DOCKER_COMPOSE} restart

# .PHONY: all build up down stop start clean re restart create-dirs

# Colors for better visualization
COLOR_RESET = \033[0m
COLOR_GREEN = \033[32m
COLOR_RED = \033[31m
COLOR_YELLOW = \033[33m
COLOR_BLUE = \033[34m

# Directories and files
SRC_DIR = srcs
DATA_DIR = /home/$(USER)/data
DB_DATA = $(DATA_DIR)/mariadb
WP_DATA = $(DATA_DIR)/wordpress
ENV_FILE = $(SRC_DIR)/.env
COMPOSE_FILE = $(SRC_DIR)/docker-compose.yml
DOCKER_COMPOSE = docker-compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE)

# Reusable docker management targets
DOCKER_STOP = docker stop $$(docker ps -qa)
DOCKER_RM = docker rm $$(docker ps -qa)
DOCKER_RMI = docker rmi -f $$(docker images -qa)
DOCKER_VOLUME_PRUNE = docker volume prune -f
DOCKER_NETWORK_PRUNE = docker network prune -f
DOCKER_SYSTEM_PRUNE = docker system prune -a --volumes -f

# Ensure data directories exist
$(DB_DATA) $(WP_DATA):
	mkdir -p $@

# Default target
.PHONY: build up down start stop logs clean prune re

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

# logs:
# 	@echo "$(COLOR_BLUE)Displaying logs...$(COLOR_RESET)"
# 	$(DOCKER_COMPOSE) logs -f

clean: 
	@echo "$(COLOR_YELLOW)Cleaning up Docker resources...$(COLOR_RESET)"
	$(DOCKER_STOP)
	$(DOCKER_RM)
	$(DOCKER_RMI)
	$(DOCKER_VOLUME_PRUNE)
	$(DOCKER_NETWORK_PRUNE)
	@echo "$(COLOR_YELLOW)Removing WordPress and MariaDB data...$(COLOR_RESET)"
	rm -rf $(DB_DATA)/* $(WP_DATA)/*
	@echo "$(COLOR_GREEN)Cleanup completed successfully!$(COLOR_RESET)"

prune: clean
	@echo "$(COLOR_YELLOW)Pruning unused Docker system resources...$(COLOR_RESET)"
	$(DOCKER_SYSTEM_PRUNE)
	@echo "$(COLOR_GREEN)Prune completed successfully!$(COLOR_RESET)"

re: clean up
	@echo "$(COLOR_BLUE)Rebuilding and restarting services...$(COLOR_RESET)"
	$(MAKE) clean
	$(MAKE) up
	@echo "$(COLOR_GREEN)Rebuild and restart completed successfully!$(COLOR_RESET)"
