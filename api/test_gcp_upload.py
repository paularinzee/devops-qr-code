from google.cloud import storage

# Your GCP bucket name
bucket_name = "mrp-qrcode-generator"

def upload_dummy_file():
    try:
        # Initialize the storage client
        storage_client = storage.Client()

        # Get the bucket
        bucket = storage_client.bucket(bucket_name)

        # Create a new blob (file object) in the bucket
        blob = bucket.blob("test-file.txt")

        # Upload a string as the content of the file
        content = "This is a test file uploaded to GCP."
        blob.upload_from_string(content)

        # Make the file public (optional)
        # blob.make_public()

        # print(f"File uploaded successfully. Public URL: {blob.public_url}")

         # Public URL (assuming bucket permissions allow public access)
        public_url = f"https://storage.googleapis.com/{bucket_name}/{blob.name}"
        print(f"File uploaded successfully. Public URL: {public_url}")
    except Exception as e:
        print(f"Error uploading file: {e}")

# Run the test
upload_dummy_file()
