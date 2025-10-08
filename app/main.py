from fastapi import FastAPI

app = FastAPI(title="Coffe EME")

@app.get("/")
def home():
    return {"message": "☕ Bienvenido a Coffe EME API"}

@app.get("/health")
def health():
    return {"status": "ok"}
