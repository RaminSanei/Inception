# 🐳 42 Inception

## ℹ️ About

**42\_Inception** is a 42 School project focused on system administration and containerization. The goal is to create a virtualized infrastructure using Docker and Docker Compose, deploying a WordPress website with a LEMP stack (Linux, Nginx, MariaDB, PHP). The project emphasizes building custom Docker images, configuring services in a Docker network, implementing SSL/TLS, managing persistent data, and automating deployment.

## 📚 Table of Contents

* [💾 Installation](#installation)
* [🛠️ Usage](#usage)
* [📂 Project Structure](#project-structure)
* [⚙️ Makefile Commands](#makefile-commands)
* [💡 Example](#example)
* [📜 License](#license)

## 💾 Installation

1. Clone the repository:

```bash
git clone https://github.com/RaminSanei/Inception.git
cd Inception
```

2. Build and run the services using Makefile:

```bash
make up
```

## 🛠️ Usage

* Start all services:

```bash
make up
```

* Stop all services:

```bash
make down
```

* Restart services:

```bash
make re
```

* Clean containers, images, and volumes:

```bash
make clean
```

* Deep prune system:

```bash
make prune
```

## 📂 Project Structure

```
├── src/                 # Source files for configurations
├── docker-compose.yml   # Docker Compose configuration
├── Makefile             # Automation commands
├── nginx/               # Nginx configuration
├── wordpress/           # WordPress container setup
├── mariadb/             # MariaDB container setup
└── ssl/                 # SSL certificates
```

## ⚙️ Makefile Commands

| Command      | Description                           |
| ------------ | ------------------------------------- |
| `make build` | Build Docker images 🏗️               |
| `make up`    | Start and recreate all services 🔄    |
| `make down`  | Stop and remove services ✋            |
| `make start` | Start stopped containers ▶️           |
| `make stop`  | Stop running containers ⏸️            |
| `make clean` | Remove containers, images, volumes 🧹 |
| `make prune` | Deep system cleanup 🗑️               |
| `make re`    | Clean and rebuild services 🔁         |

## 💡 Example

```bash
# Start the environment
make up

# Open WordPress site
https://localhost
```

## 📜 License

This project is for educational purposes at 42 School 🎓 and is not intended for commercial use 🚫.
