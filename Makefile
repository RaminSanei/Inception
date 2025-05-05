
DOCKER_COMPOSE = docker-compose -f srcs/docker-compose.yml
VOLUME_DIR = /home/ssanei/data

all: up

# Target to create necessary directories
create_dirs:
	mkdir -p ${VOLUME_DIR}/mariadb
	mkdir -p ${VOLUME_DIR}/wordpress

build: create_dirs
	${DOCKER_COMPOSE} build

up: build
	${DOCKER_COMPOSE} up -d

down:
	${DOCKER_COMPOSE} down

stop:
	${DOCKER_COMPOSE} stop

start:
	${DOCKER_COMPOSE} start

clean:
	docker rm -f mariadb wordpress nginx
	docker rmi -f mariadb wordpress nginx
	docker volume rm $(shell docker volume ls -q)
	docker system prune -a -f

re: clean all

restart:
	${DOCKER_COMPOSE} restart

.PHONY: all build up down stop start clean re restart create-dirs
