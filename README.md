# DevOps Portfolio - Ayeni Oluwadamilare

This repository contains my personal portfolio website with a complete CI/CD pipeline implementation using Docker and Jenkins.

## Project Overview

This project demonstrates a practical implementation of DevOps practices with:

- Responsive portfolio website built with HTML, CSS, and JavaScript
- Docker containerization for consistent deployment
- Automated CI/CD pipeline with Jenkins
- Integration with GitHub for version control

## Portfolio Features

- Responsive design that works on all devices
- Sections for showcasing skills, projects, and experience
- Real-time CI/CD pipeline status display
- Contact form for visitors

## DevOps Implementation

### Docker

The portfolio is containerized using Docker with Nginx as the web server. The Dockerfile in this repository defines how the container is built.

#### Local Development

To run the portfolio locally:

```bash
# Build the Docker image
docker build -t portfolio .

# Run the container
docker run -d -p 8080:80 --name portfolio portfolio

# Access the website at http://localhost:8080
```

### Jenkins Pipeline

The CI/CD pipeline is defined in the Jenkinsfile and includes the following stages:

1. **Checkout**: Clone the repository from GitHub
2. **Build**: Create a Docker image of the portfolio
3. **Test**: Verify the container can serve the website correctly
4. **Push**: Upload the Docker image to a registry
5. **Deploy**: Deploy the new version to the production server

## Setting Up the Pipeline

### Prerequisites

- Jenkins server with Docker installed
- DockerHub account (or other container registry)
- GitHub repository for your portfolio

### Jenkins Setup

1. Install required Jenkins plugins:
   - Docker Pipeline
   - Git
   - Pipeline
   - SSH Agent

2. Configure credentials in Jenkins:
   - DockerHub credentials
   - SSH credentials for deployment server

3. Create a new Pipeline job in Jenkins:
   - Select "Pipeline script from SCM"
   - Set the repository URL
   - Set the branch to monitor
   - Set the script path to "Jenkinsfile"


© 2025 Ayeni Oluwadamilare. All rights reserved.
