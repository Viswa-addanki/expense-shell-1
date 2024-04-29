#!/bin/bash

source ./common.sh
check_root

dnf install nginx -y &>>$LOGFILE
VALIDATE $? "Installing nginx"

systemctl enable nginx &>>$LOGFILE
VALIDATE $? "enable nginx"

systemctl start nginx &>>$LOGFILE
VALIDATE $? "starting nginx"

rm -rf /usr/share/nginx/html/* &>>$LOGFILE
VALIDATE $? "Removing existing "

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip
VALIDATE $? "Downloading front end code" &>>$LOGFILE


cd /usr/share/nginx/html

unzip /tmp/frontend.zip &>>$LOGFILE
VALIDATE $? "Extarcting Frontend code"

cp /home/ec2-user/expense-shell/expense.conf /etc/nginx/default.d/expense.conf &>>$LOGFILE
VALIDATE $? "Copied Expense Path"

systemctl restart nginx &>>$LOGFILE
VALIDATE $? "nginx is restared"