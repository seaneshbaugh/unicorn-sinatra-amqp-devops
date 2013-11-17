# Unicorn + Sinatra + AMQP Devops

This is the server setup repository for a simple demonstration of Unicorn, Sinatra, and AMQP working together. The actual demo repository can be found [here](https://github.com/seaneshbaugh/unicorn-sinatra-amqp). This project uses [https://github.com/scottvrosenthal/iron_chef](iron_chef).

The Nginx configuration is set to use amqpdemo.dev as the domain. You'll want to edit your hosts file to make this actually work.

## Initial Server Setup

For this demo I've been using a [CentOS 6.4 minimal install](http://isoredirect.centos.org/centos/6/isos/x86_64/) virtual machine as my "production" environment. Any Red Hat-like distro, including Amazon AMI, will do.

Since I'm using a minimal install it's missing some packages I always end up using at some point:

   $ cap production-web bootstrap:os

Next, Chef needs to be setup on the server:

   $ cap production-web bootstrap:chef

## Install Dependencies

In `nodes/production-web.yml` change the roles entry to look like this:

   roles:
     - install_web_server

And then apply that role:

   $ cap production-web chef:apply

This will install all of the application's dependencies (and some other packages for good measure).

## Setup Web Server

In `nodes/production-web.yml` change the roles entry to look like this:

   roles:
     - setup_web_server

And then apply that role:

   $ cap production-web chef:apply

This will create the deployer user and do the initial setup for the application.
