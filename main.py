from fastapi import FastAPI
from datetime import datetime
import os

app = FastAPI(title="App Runner Sample API", version="1.0.0")

@app.get("/")
async def root():
    return {
        "message": "Hello from AWS App Runner with FastAPI!",
        "timestamp": datetime.now().isoformat(),
        "environment": os.getenv("ENVIRONMENT", "development")
    }
    
@app.get("/health")
async def health_check():
    return {"status": "healthy"}

@app.get("/items/{item_id}")
async def read_item(item_id: int, q: str = None):
    return {"item_id": item_id, "q": q}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8080)