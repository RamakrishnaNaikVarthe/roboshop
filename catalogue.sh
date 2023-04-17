echo -e "\e[36m<<<<<<<configuring nohdejs repos >>>>>>>>\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[36m<<<<<<< installing nodejs >>>>>>>>>>\e[0m"
yum install nodejs -y
echo -e "\e[36m<<<<<<<<< application user >>>>>>>>>\e[0m"

useradd roboshop
echo -e "-e[36m<<<<<<<< create application directory\e[0m"
mkdir /app
echo -e "\e[36m<<<<<<<<< download app content >>>>>>>>>\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
rm -rf /app
cd /app

unzip /tmp/catalogue.zip
cd /app
npm install
cp catalogue.service /etc/systemd/system/catalogue.service
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue
cp mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y
mongo --host mongodb-dev.krishnaik.shop </app/schema/catalogue.js