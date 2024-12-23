from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
import qrcode
from google.cloud import storage
import os
from io import BytesIO

# Load environment variables
from dotenv import load_dotenv
load_dotenv()

# Set Google Application Credentials from .env
# os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = os.getenv("GOOGLE_APPLICATION_CREDENTIALS")

app = FastAPI()

# Allowing CORS for local testing
origins = [
    "http://localhost:3000"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_methods=["*"],
    allow_headers=["*"],
)

# GCP Storage Configuration
bucket_name = os.getenv("GCP_BUCKET_NAME")  # Set your GCP bucket name in the environment
if not bucket_name:
    raise RuntimeError("GCP bucket name is not set in the environment variables.")

# Initialize the GCP storage client
storage_client = storage.Client()

@app.post("/generate-qr/")
async def generate_qr(url: str):
    # Generate QR Code
    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_L,
        box_size=10,
        border=4,
    )
    qr.add_data(url)
    qr.make(fit=True)

    img = qr.make_image(fill_color="black", back_color="white")
    
    # Save QR Code to BytesIO object
    img_byte_arr = BytesIO()
    img.save(img_byte_arr, format='PNG')
    img_byte_arr.seek(0)

    # Generate file name for GCP
    file_name = f"qr_codes/{url.split('//')[-1]}.png"

    try:
        # Upload to GCP Cloud Storage
        bucket = storage_client.bucket(bucket_name)
        blob = bucket.blob(file_name)
        blob.upload_from_file(img_byte_arr, content_type='image/png')
        # blob.make_public()  # Make the file publicly accessible
        
        # Generate the public URL
        # public_url = blob.public_url
        public_url = f"https://storage.googleapis.com/{bucket_name}/{file_name}"
        return {"qr_code_url": public_url}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Failed to upload the QR code to GCP: {e}")
