from flask import Flask
from redis import Redis, RedisError
import os
import socket

# Connect to Redis
redis = Redis(host=os.getenv("REDIS_URL","task8-myrediscache.redis.cache.windows.net"), port=os.getenv("REDIS_PORT","6380"), db=0, password=os.getenv("REDIS_PWD","2zhslprKjg4CPZi7JpyRc83AvYrmEDx1IAzCaHIKsbY="), ssl=os.getenv("REDIS_SSL_MODE",True))

app = Flask(__name__)

@app.route("/") 
def hello():
    try:
        visits = redis.incr("counter")
    except RedisError:
        visits = "<i>cannot connect to Redis, counter disabled</i>"

    html = "<h3>Hello from {name}!</h3>" \
           "<b>Hostname:</b> {hostname}<br/>" \
           "<b>Visits:</b> {visits}"
    return html.format(name=os.getenv("CREATOR"), hostname=socket.gethostname(), visits=visits)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)