#!/bin/bash

yum install -y httpd

systemctl enable httpd
systemctl start httpd

yum install -y git
