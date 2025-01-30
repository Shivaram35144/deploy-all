# Scalable Online Platform with Automated DevOps Workflow

This project demonstrates a scalable platform with two Spring Boot microservices, fully integrated with DevOps tools to showcase best practices in automation, containerization, orchestration, and monitoring. The goal is to automate the entire CI/CD pipeline and utilize modern DevOps tools.
---

## Folder Structure
```
/Users/shivaram/Desktop/deploy-pjt/
├── .DS_Store
├── .gitignore
├── User-to-add-env.md
├── ansible/
│   ├─] inventory.sample (ignored)
│   ├─] key-pair-ec2 (ignored)
│   ├── main.yaml
│   └── variables.yaml
├── app1/
│   ├── Dockerfile
│   ├── app.py
│   └── requirements.txt
├── app2/
│   ├── Dockerfile
│   ├── app.py
│   └── requirements.txt
├─] currectstructure.sample (ignored)
├── docker-compose.yaml
├── jenkins/
│   ├── Jenkinsfile
│   └── steps.md
├── monitoring/
├── readme.md
└── terraform/
    ├─] .terraform/ (ignored)
    ├── .terraform.lock.hcl
    ├── aws_details/
    ├── ec2inst/
    │   ├─] key-pair-ec2 (ignored)
    │   ├─] key-pair-ec2.pub (ignored)
    │   ├── keypair.tf
    │   ├── main.tf
    │   ├── output.tf
    │   └── secgrp.tf
    ├── main.tf
    ├── output.tf
    ├── s3_bucket/
    │   ├── main.tf
    │   └── output.tf
    ├─] terraform.tfstate (ignored)
    ├── terraform.tfstate.backup
    └── variables.tf

```

---

## Roadmap

### Day 1: Set Up Infrastructure with Terraform
1. Install and configure Terraform on your local machine.
2. Write a `main.tf` file to provision an EC2 instance and S3 bucket.
3. Apply the configuration:
   ```bash
   terraform init
   terraform fmt
   terraform validate
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

4. **Run the Playbook**:
    ```bash
    ansible-playbook -i inventory setup.yml
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
```mvn clean install`` to build
```java -jar <jarname>``` to run 8080 usually

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



