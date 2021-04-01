FROM tiangolo/uvicorn-gunicorn-fastapi:python3.7
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY ./app /app
