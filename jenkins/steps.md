1. Log in to jenkins `http://your-ec2-ip:8080`
2. manage jenkins -> manage credentials -> Global credentials -> add git hub ssh key
3. New item -> Pipeline -> Pipeline script from SCM 
- use github repo (`Give ssh url`)
- set our jenkisnfile as script
