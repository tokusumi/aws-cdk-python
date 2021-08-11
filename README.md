# AWS-CDK-Python

Source of Non official base image ([here](https://hub.docker.com/r/tokusumi/aws-cdk-python)) for working with AWS CDK in Python

## Tags

- cdk1.100-py3.7:
  - Node: v14
  - Python: v3.7
  - AWS CDK: v1.1
  - AWS CLI: v2

## How to use

### Create custom image

Here we need to create some files. The sample is located in [`how-to-use/`]("./how-to-use") .

At first, create `Dockerfile` as:

```Dockerfile
FROM tokusumi/aws-cdk-python:cdk1.100-py3.7

ADD ./requirements.txt /app/requirements.txt
RUN python3 -m pip install --no-cache-dir -r /app/requirements.txt

CMD ["/bin/bash"]
```

Create `requirements.txt` and write `CDK` library for your usecase. For example:

```txt
aws-cdk.aws-lambda==1.100.0
aws-cdk.aws-dynamodb==1.100.0
aws-cdk.aws-events-targets==1.100.0
aws-cdk.aws_lambda_event_sources==1.100.0
boto3
```

Create `.env` file for AWS configurations (See details at [AWS Userguid](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html)). `docker-compose` read this automatically:

```env
AWS_ACCESS_KEY_ID=<get access key id in AWS console>
AWS_SECRET_ACCESS_KEY=<get secret access key in AWS console>
AWS_DEFAULT_REGION=<set default region. e.g.: ap-northeast-1>
```

Create `docker-compose.yml` to use above custom image as:

```yaml
version: "3"
services:
    aws-cdk-py:
        command: /bin/bash
        build: .
        volumes:
            - ./app:/root/app
        environment: 
            - AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
            - AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
            - AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}
        tty: true
```

Build custom docker image:

```bash
docker-compose build
```

### Use it

Run `bash`:

```bash
$ docker-compose run --rm aws-cdk-py /bin/bash
🐳 6bd6b289c89e:~ # nodejs -v
v14.17.4
🐳 6bd6b289c89e:~ # python3 -V
Python 3.7.6
🐳 6bd6b289c89e:~ # aws --version
aws-cli/2.2.28 Python/3.8.8 Linux/4.19.128-microsoft-standard exe/x86_64.debian.9 prompt/off
🐳 6bd6b289c89e:~ # cdk --version
1.118.0 (build a4f0418)
```

Or you can run `AWS CDK` command directly:

```bash
$ docker-compose run --rm aws-cdk-py cdk --version
1.118.0 (build a4f0418)
```
