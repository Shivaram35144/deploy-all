from flask import Flask, jsonify
import requests

app = Flask(__name__)

@app.route('/')
def home():
    return "Welcome to App1!"

@app.route('/call-app2')
def call_app2():
    # Communicating with app2 (localhost as both are on the same EC2)
    try:
        response = requests.get('http://app2:8082')  # Using 'app2' as the service name in Docker Compose
        return jsonify({"message": "App1 called App2", "response_from_app2": response.text})
    except requests.exceptions.RequestException as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8081)
