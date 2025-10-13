import os
from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from fastapi.middleware.trustedhost import TrustedHostMiddleware
# ProxyHeadersMiddleware is not available in FastAPI

app = FastAPI(title="Coffee EME")

# 🔹 Middleware para aceptar hosts y manejar encabezados reales de Cloud Run
app.add_middleware(TrustedHostMiddleware, allowed_hosts=["*"])

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
static_dir = os.path.join(BASE_DIR, "static")
templates_dir = os.path.join(BASE_DIR, "templates")

app.mount("/static", StaticFiles(directory=static_dir), name="static")
templates = Jinja2Templates(directory=templates_dir)


@app.get("/", response_class=HTMLResponse)
async def read_root(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})


@app.get("/api/status")
async def api_status():
    return {"status": "ok", "service": "coffee-eme"}
