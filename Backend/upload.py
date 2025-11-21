import os
import requests
from envs import IMAGE_API_KEY


def upload(base: str):
    """
    Uploads a base64-encoded image string to imgbb.com
    """
    if not IMAGE_API_KEY:
        raise ValueError("Missing API key. Please set API in your .env file.")

    url = "https://api.imgbb.com/1/upload"
    payload = {
        "key": IMAGE_API_KEY,
        "image": base
    }

    response = requests.post(url, data=payload)
    response.raise_for_status()

    return response.json()
