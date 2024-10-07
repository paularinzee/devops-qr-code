FROM python:3.9-slim

# Set working directly in the container
WORKDIR /usrsrc/app

# Copy the dependencies file to the working directly
COPY requirements.txt ./

# Install any needed packages from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# copy the content of the local src directory to the working directory
COPY . .

# Run the app
CMD [ "unicorn", "main:app", "--host", "0.0.0.0", "--port", "80" ]