interface GetProcessedVideoProps {
  video_file: File;
}

export const getProcessedVideo = async (data: GetProcessedVideoProps) => {
  const formData = new FormData();
  formData.append("video_file", data.video_file);

  return fetch(`${import.meta.env.PUBLIC_API_URL}/api/core/`, {
    method: "POST",
    body: formData,
  });
};
