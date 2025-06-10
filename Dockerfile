FROM python:3.11-slim

WORKDIR /app

# uvのインストール行を削除
# RUN pip install uv

# pyproject.tomlとuv.lockの代わりにrequirements.txtをコピー
COPY requirements.txt ./

# uv syncの代わりにpip installを使用
RUN pip install -r requirements.txt

COPY . .

EXPOSE 8080

# uv runを削除してuvicornを直接実行
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]