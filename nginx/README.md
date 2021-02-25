# NGINX

## Tl;Dr: [lighthouse report](nginx_report.pdf) 

Just about had an ego death from this one.

Based on these 2 tutorials:

- [Deploy FastAPI Application on Ubuntu with Nginx, Gunicorn, and Unicorn](https://dev.to/shuv1824/deploy-fastapi-application-on-ubuntu-with-nginx-gunicorn-and-uvicorn-3mbl)
- [A Simple API in Python using Flask and Nginx and subsequent deployment on AWS EC2](https://medium.com/@varunchitale/a-simple-python-api-using-flask-with-nginx-setup-on-aws-ec2-4a380ceaf006)

Despite the title of the last tutorial, this was anything but simple. 

The biggest issue I ran into was the fact that sites-enabled was not being honored. Eventually, I ended up rewriting `nginx.conf` and hardcoding the configuration. Symlinks are hard.

I did this one on AWS because I knew I would be able to spin up an ec2 instance and get going fairly quickly. The challenge would be configuring NGINX.

I ran the [lighthouse](nginx_report.pdf) report against the `redoc` endpoint as `/` produces json and is therefore NOT an auditable mime type for lighthouse.

