from flask import Flask, request, jsonify, render_template
from flask_cors import CORS
import deploy


def get_web_service_app(inference_fn): 

    app = Flask(__name__)
    CORS(app)

    @app.route('/') # 경로에 대한 라우트를 정의
    def index():
        return render_template('index.html') # index.html 파일을 랜더링

    @app.route('/api', methods=['POST']) # 이 라우트는 POST 메서드를 사용
    def api():
        query_sentence = request.json # api 함수는 클라이언트로부터 JSON 형식의 데이터를 받아옴
        output_data = inference_fn(query_sentence)
        response = jsonify(output_data) # OUTPUT 데이터를 JSON 형식으로 변환하여 클라이언트에게 반환
        return response
        
    return app

if __name__ == '__main__':
    app=get_web_service_app(deploy.inference_fn)
    app.run(debug=True)

    