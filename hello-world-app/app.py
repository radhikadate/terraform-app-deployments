from flask import Flask
import requests

app = Flask(__name__)

def get_availability_zone():
    try:
        # Get AZ from EC2 metadata service
        response = requests.get(
            'http://169.254.169.254/latest/meta-data/placement/availability-zone',
            timeout=2
        )
        return response.text
    except:
        return "Unknown"

@app.route('/')
def hello():
    az = get_availability_zone()
    return f"Hello World from {az}!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=4000)