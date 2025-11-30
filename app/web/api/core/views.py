from typing import Annotated

from fastapi import APIRouter, UploadFile, Depends, Response
from fastapi.responses import StreamingResponse

from app.web.api.core.dependenices import get_video_service
from app.web.api.core.service import VideoService

router = APIRouter()


@router.post("/", response_description='stream')
async def send_message(
    video_file: UploadFile,
    video_service: Annotated[VideoService, Depends(get_video_service)] ,
):
    result = await video_service.process(video_file)

    return StreamingResponse(result, media_type="video/mp4")
