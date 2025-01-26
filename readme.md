# Scalable Online Platform with Automated DevOps Workflow

This project demonstrates a scalable platform with two Spring Boot microservices, fully integrated with DevOps tools to showcase best practices in automation, containerization, orchestration, and monitoring. The goal is to automate the entire CI/CD pipeline and utilize modern DevOps tools.

---

## Project Objectives
1. Build a scalable platform with two Spring Boot applications.
2. Implement a CI/CD pipeline using Jenkins to deploy to an EC2 instance automatically.
3. Use Docker for containerization and optionally Kubernetes for orchestration.
4. Automate infrastructure provisioning and configuration with Terraform and Ansible.
5. Integrate AWS services like EC2 and S3.
6. Apply monitoring using AWS CloudWatch.
7. Follow best practices for each DevOps tool.

---

## Tech Stack
- **Spring Boot**: API routes and communication between microservices.
- **Jenkins**: CI/CD pipeline.
- **Terraform**: Infrastructure as Code (IaC) for provisioning AWS resources.
- **Ansible**: Configuration management for EC2 instance setup.
- **Docker**: Containerization for both applications.
- **Kubernetes**: Orchestration for Docker containers (if cost and domain limitations are resolved).
- **AWS Services**: EC2, S3, and CloudWatch for monitoring.

---

## Folder Structure
```
scalable-platform/
├── terraform/                     # Terraform scripts for infrastructure provisioning
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfstate          # (added to .gitignore)
│
├── ansible/                       # Ansible playbooks and inventory
│   ├── inventory.ini
│   ├── setup.yml                  # Playbook to configure EC2 instance
│   └── roles/                     # Optional roles for Ansible
│       └── common/
│           ├── tasks/
│           │   └── main.yml
│           └── templates/
│
├── docker/                        # Dockerfiles for Spring Boot services
│   ├── app1/                      # Service 1
│   │   ├── Dockerfile
│   │   ├── src/                   # Source code for App 1
│   │   └── .dockerignore
│   └── app2/                      # Service 2
│       ├── Dockerfile
│       ├── src/                   # Source code for App 2
│       └── .dockerignore
│
├── k8s/                           # Kubernetes manifests (if using Kubernetes)
│   ├── app1-deployment.yaml
│   ├── app1-service.yaml
│   ├── app2-deployment.yaml
│   ├── app2-service.yaml
│   └── ingress.yaml               # Ingress configuration (if applicable)
│
├── jenkins/                       # Jenkins-related files
│   ├── Jenkinsfile                # CI/CD pipeline configuration
│   └── scripts/                   # Optional helper scripts for Jenkins jobs
│       └── build-and-deploy.sh
│
├── monitoring/                    # Monitoring and logging configurations
│   ├── cloudwatch/                # CloudWatch configuration
│   │   ├── log-group.json
│   │   ├── metric-filters.json
│   │   └── alarms.json
│   └── grafana-prometheus/        # Placeholder for learning later
│
├── app1/                          # Spring Boot project for service 1
│   ├── pom.xml
│   ├── src/
│   └── target/                    # Built artifacts (added to .gitignore)
│
├── app2/                          # Spring Boot project for service 2
│   ├── pom.xml
│   ├── src/
│   └── target/                    # Built artifacts (added to .gitignore)
│
├── docs/                          # Documentation for the project
│   ├── README.md
│   ├── CONTRIBUTING.md
│   └── architecture-diagram.png
│
├── scripts/                       # General-purpose helper scripts
│   ├── cleanup.sh                 # Cleans up unused resources
│   └── deploy.sh                  # Deploys all components manually
│
└── .gitignore                     # Files and folders to exclude from version control
```

---

## Roadmap

### Day 1: Set Up Infrastructure with Terraform
1. Install and configure Terraform on your local machine.
2. Write a `main.tf` file to provision an EC2 instance and S3 bucket.
3. Apply the configuration:
   ```bash
   terraform init
   terraform plan
   terraform apply

## Day 2: Configure EC2 with Ansible
1. **Install Ansible**:
   - Install Ansible on your local machine or control node.
   - Ensure you have SSH access to the EC2 instance.

2. **Set Up Inventory File**:
   - Create `inventory.ini` with the EC2 instance details:
     ```ini
     [ec2]
     <EC2_PUBLIC_IP> ansible_ssh_user=ubuntu ansible_ssh_private_key_file=~/.ssh/<your_key>.pem
     ```

3. **Write Ansible Playbook**:
   - Create `setup.yml` to:
     - Install Java and Docker on the EC2 instance.
     - Configure Docker to start on boot.
   ```yaml
   ---
   - hosts: ec2
     become: yes
     tasks:
       - name: Install Java
         apt:
           name: default-jdk
           state: present

       - name: Install Docker
         apt:
           name: docker.io
           state: present

       - name: Start and enable Docker service
         systemd:
           name: docker
           enabled: yes
           state: started
    ```
4. **Run the Playbook**:
    ```bash
    ansible-playbook -i inventory.ini setup.yml
    ```


## Day 3: Containerize Applns with Docker
1. Create Dockerfiles for each springboot appln
2. Build the docker images 
```bash
docker build -t app1-image ./docker/app1
```
3. Run containers locally
```bash
docker run -d --name app1 -p 8081:8080 app1-image
```

## Day 4: Automate CICD with Jenkins
1. Configure jenkins file
```bash
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                script {
                    sh 'mvn clean package -f app1/pom.xml'
                    sh 'mvn clean package -f app2/pom.xml'
                }
            }
        }
        stage('Docker Build') {
            steps {
                script {
                    sh 'docker build -t app1-image ./docker/app1'
                    sh 'docker build -t app2-image ./docker/app2'
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    sh 'docker run -d --name app1 -p 8081:8080 app1-image || true'
                    sh 'docker run -d --name app2 -p 8082:8080 app2-image || true'
                }
            }
        }
    }
}
```
2. Push code to main branch and trigger pipeline

## Day 5: Kubernetes - Minikube

1. Write K8 manifests `app1-deployment.yaml`
eg: 
```bash
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app1
spec:
  replicas: 2
  selector:
    matchLabels:
      app: app1
  template:
    metadata:
      labels:
        app: app1
    spec:
      containers:
      - name: app1
        image: app1-image
        ports:
        - containerPort: 8080

```
2. Apply the manifests
```bash
kubectl apply -f k8s/
```

## Day 6: Springboot

1. Develop
2. Build using Maven
3. Ensure CICD appropriately builds 

## Day 7: Monitoring

1. AWS Cloudwatch, Grafana, Prometheus

```bash
{
    "metrics": {
        "append_dimensions": {
            "InstanceId": "${aws:InstanceId}"
        },
        "metrics_collected": {
            "disk": {
                "measurement": ["used_percent"],
                "resources": ["*"]
            },
            "mem": {
                "measurement": ["used_percent"]
            }
        }
    }
}
```



