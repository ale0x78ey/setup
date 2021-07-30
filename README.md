# My environment

Just some ansible playbooks for local environment.

## To use amazon.aws.aws_s3

```bash
ansible-galaxy collection install amazon.aws
```

## To use aws
```bash
sudo pip install -U awscli==1.18.105  \
                    botocore==1.17.28 \
                    boto3==1.9.253    \
                    s3transfer==0.3.3

sudo ls -al /root/.aws/
```
