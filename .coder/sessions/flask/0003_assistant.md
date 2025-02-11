### main.py [coder:save]
```python
from flask import Flask, request, Response

app = Flask(__name__)
app.config['BASIC_AUTH_USERNAME'] = 'coder'
app.config['BASIC_AUTH_PASSWORD'] = 'coder'

from functools import wraps
from werkzeug.security import generate_password_hash, check_password_hash

def check_auth(username, password):
    """This function is called to check if a username /
    password combination is valid.
    """
    return username == app.config['BASIC_AUTH_USERNAME'] and password == app.config['BASIC_AUTH_PASSWORD']

def authenticate():
    """Sends a 401 response that enables basic auth"""
    return Response(
    'Could not verify your access level for that URL.\n'
    'You have to login with proper credentials', 401,
    {'WWW-Authenticate': 'Basic realm="Login Required"'})

def requires_basic_auth(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        auth = request.authorization
        if not auth or not check_auth(auth.username, auth.password):
            return authenticate()
        return f(*args, **kwargs)
    return decorated

@app.route('/')
@requires_basic_auth
def hello_world():
    return "Hello, World!", 200

if __name__ == '__main__':
    app.run(port=8081)
```
[coder:end]
