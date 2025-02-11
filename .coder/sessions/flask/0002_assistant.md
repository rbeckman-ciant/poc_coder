### main.py [coder:save]
```
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return "Hello, World!", 200

if __name__ == '__main__':
    app.run(port=8081)
```
[coder:end]