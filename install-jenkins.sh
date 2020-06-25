#!/bin/bash
sudo yum -y update
yum remove -y java
yum install -y java-1.8.0-openjdk
yum install -y maven 
yum install -y git
yum update -y
yum install docker -y
#sudo usermod -a -G docker jenkins
#sudo service docker start
sudo chkconfig docker on
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
yum install -y jenkins
sudo usermod -a -G docker jenkins
sudo chkconfig jenkins on
sudo service docker start
sudo service jenkins start