----
# Orders Management In Mass Spectrometry Laboratory

This is a web-based application written in Ruby on Rails. It can be used to store information, for example, about orders (analyses) in mass spectrometry laboratory.

## REQUIREMENTS

- Redis Server
- Ruby on Rails

## INSTALLATION (example based on Ubuntu Server 15.10)

#### Redis installation
```
sudo apt-get install redis-server
```
Installation of Ruby on Rails has been omitted. You can do this, for example, using rvm.

#### App installation
```
sudo apt-get install nodejs

git clone https://github.com/pablomontoja/OrdersManagementInMSLab.git

cd OrdersManagementInMSLab

bundle install

rake db:migrate

rails server
```

#### The easiest method - use VirtualBox image

I prepared Ubuntu Server image (.vdi container) that can be used to run my app. You need to configure VirtualBox Port Forwarding (add port forwarding rule with Host Port=3000 and Guest Port=3000).

You can download the image from:

https://app.box.com/s/007yun4iju7ht4q9udvup0ffa4z2ewhf

root password: admin

user login: admin

user password: admin


After login as admin go to /home/admin/rails and clone the repo:
```
git clone https://github.com/pablomontoja/OrdersManagementInMSLab.git

bundle install

rake db:migrate

rails server -b 10.0.2.15
```

Now in your host system in browser go to:
```
127.0.0.1:3000
```
----
