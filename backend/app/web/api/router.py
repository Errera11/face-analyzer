from fastapi.routing import APIRouter

from app.web.api import core, monitoring

api_router = APIRouter()
api_router.include_router(monitoring.router)
api_router.include_router(core.router, prefix="/core", tags=["core"])
