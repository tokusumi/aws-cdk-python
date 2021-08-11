FROM tokusumi/aws-cdk-python:cdk1.100-py3.7

ADD ./requirements.txt /app/requirements.txt
RUN python3 -m pip install --no-cache-dir -r /app/requirements.txt

CMD ["/bin/bash"]