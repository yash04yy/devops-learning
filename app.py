from flask import Flask;
import random

app = Flask(__name__)

quotes = [                    
    "'The best way to predict the future is to create it.' - Peter Drucker",
    "'The only way to do great work is to love what you do.' - Steve Jobs",
    "'Your time is limited, don't waste it living someone else's life.' - Steve Jobs",
    "'Simplicity is the ultimate sophistication.' - Leonardo da Vinci"
]

@app.route("/")
def get_quote():
    return random.choice(quotes)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)