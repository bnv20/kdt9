import argparse # 파이썬 명령행 파싱 모듈
import io 
import os
import json
import glob 
from PIL import Image
from uuid import uuid4 # 유니버설 고유 식별자 생성을 위한 모듈.
import torch
from flask import Flask, render_template, request, redirect, url_for, session
from ast import literal_eval # 문자열을 파이썬 자료구조로 변환
import collections # 컨테이너에 저장된 요소들을 세는데 사용되는 모듈
import numpy as np
import sys

# 폴더안의 파일 삭제 함수

def DeleteAllFiles(filePath):
    if os.path.exists(filePath):
        for file in os.scandir(filePath):
            os.remove(file.path)
            
app = Flask(__name__)

# 웹 서버에서 이미지를 업로드하고 Yolo 모델을 사용하여 이미지에서 객체를 탐지한 결과를 반환
@app.route("/detect", methods=["GET","POST"])
def predict():
    if request.method == "POST":
        DeleteAllFiles('static/aft')
        DeleteAllFiles('static/bef')
        
        # 다중파일 업로드
        if "file" not in request.files:
            return redirect(request.url)
        file = request.files.getlist("file")
        if not file:
            return
        
        resultlist = [] # 결과 리스트
        pf = [] # pass fail 리스트
        for file in file:
            filename = file.filename.rsplit("/")[0] # 파일 경로에서 파일명만 추출
            print("진행 중 파일 :", filename)
            
            img_bytes = file.read()
            # 바이트 스트림은 파일과 유사한 인터페이스를 가진 객체
            img = Image.open(io.BytesIO(img_bytes)) # img_bytes를 바이트 스트림으로 변환
            # img 객체를 static/bef/ 디렉토리에 filename 이름으로 JPEG 포멧의 이미지 파일로 저장
            img.save(f"static/bef/{filename}", format="JPEG")
            print('원본 저장')
            
            results = model(img, size=640)
            # 각 레코드를 별도의 json 객체로 표현
            results_list = results.pandas().xyxy[0].to_json(orient='records')
            # 문자열 형식의 데이터를 리스트 타입으로 변환
            results_list = literal_eval(results_list)
            # 탐지된 모든 객체의 이름(클래스) 목록을 포함
            classes_list = [item["name"] for item in results_list]
            # 저장된 요소들을 세는데 사용되는 모듈
            result_counter = collections.Counter(classes_list)
            
            results.render() # results.imgs에 바운딩 박스와 라벨 처리
            
            for img in results.ims:
                img_base64 = Image.fromarray(img) # 이미지를 배열로 변환
                img_base64.save(f"static/aft/{filename}", format='JPEG')
                print('디텍트 저장')
                
            resultlist.append(json.dumps(dict(result_counter)))
            
            # 탐지된 객체의 이름 가져오기
            data = results.pandas().xyxy[0][['name']].values.tolist()
            print("데이터", data)
            
            if len(data) == 0:
                pf.append("PASS")
            if len(data) != 0:
                pf.append("FAIL")
                
            root = "static/aft"
            if not os.path.isdir(root):
                return "Error : not found!"
            files = []
            for file in glob.glob("{}/*.*".format(root)):
                fname = file.split(os.sep)[-1]
                files.append(fname)
            print("파일스:", files)
            
            if len(files) > 0:
                firstimage = "static/aft"+files[0]
            else:
                pass
            
            datanum = len(pf)
            rate = round(pf.count('PASS') / len(pf), 3)
            correct = pf.count('PASS')
            
            print(resultlist)
        return render_template("imageshow.html", files=files, resultlist=resultlist, pf=pf,datanum=datanum,
                               rate=rate, correct=correct,firstimage=firstimage,enumerate=enumerate,len=len,
                               results_list=results_list)
    return render_template("detect.html")

@app.route('/')
def home():
    return render_template('index.html')

if __name__== "__main__":
    parser = argparse.ArgumentParser(
        description="Flask app exposing yolov5 models")
    parser.add_argument("--port", default=5000, type=int, help="port number")
    args = parser.parse_args()
        
            
# local model
    model = torch.hub.load(
        'ultralytics/yolov5', 'custom', 'yolov5l-best-230214.pt', autoshape=True,
    )
    model.eval()
    
    flask_options = dict(
        host='0.0.0.0',
        debug=True,
        port=args.port,
        thread=True,
    )
    
    app.run(**flask_options)
            
            