FROM python:3.9-slim

WORKDIR /usr/src/app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt


COPY . .

EXPOSE 8000

#CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
# Set the entrypoint command to use the credentials at runtime
CMD ["sh", "-c", "echo \"$GOOGLE_APPLICATION_CREDENTIALS\" > /etc/gcp/credentials.json && uvicorn main:app --host 0.0.0.0 --port 80"]