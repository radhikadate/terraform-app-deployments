from flask import Flask
import requests
import socket

app = Flask(__name__)

def get_availability_zone():
    try:
        # Get AZ from EC2 metadata service (IMDSv2)
        # First get token
        token_response = requests.put(
            'http://169.254.169.254/latest/api/token',
            headers={'X-aws-ec2-metadata-token-ttl-seconds': '21600'},
            timeout=2
        )
        token = token_response.text
        
        # Then get AZ using token
        response = requests.get(
            'http://169.254.169.254/latest/meta-data/placement/availability-zone',
            headers={'X-aws-ec2-metadata-token': token},
            timeout=2
        )
        return response.text
    except Exception as e:
        # Fallback to hostname
        return f"Unknown (Error: {str(e)[:50]})"

@app.route('/')
def hello():
    az = get_availability_zone()
    hostname = socket.gethostname()
    return f"Hello World from {az}! (Host: {hostname})"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=4000)