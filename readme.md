Note: See ```Pjt-details.md``` for directory structure.



# Generate Public and Pvt RSA keys for ssh-ing into ec2
```
ssh-keygen -t rsa -b 4096 -f /path/to/your/directory/key-name
```
# Go Into Terraform Folder

```bash
   terraform init
   terraform fmt
   terraform validate
   terraform plan
   terraform apply
```


# If not already created the docker image go into each app folder

Log in to docker by ``` docker login```
## for linux
``` bash
docker buildx build --platform linux/amd64,linux/arm64 -t shivram35144/flask-app-2:v2 --push .


Note: . at the end referes that the dockerfile is in the current directory
```

``` bash
docker build -t shivram35144/flask-app-2:v2 .
docker push shivram35144/flask-app-2:v2
```

## Run ansible (verify inventory file created after running terraform)

In ansible directory

``` bash
ansible-playbook ansible-playbook -i inventory main.yaml
```

### Verify endpoints using ```http://<ec2-pub-id>:<port>/endpoint```

---
---
---

## Jenkins