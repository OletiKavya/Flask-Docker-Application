# Use an official Python runtime as a parent image
FROM python:3.12.4-slim

# Set the working directory in the container
WORKDIR /app

# Copy only requirements.txt first to leverage Docker cache
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

RUN pip install flask
RUN pip install flask_sqlalchemy
RUN pip install flask_jwt_extended


# Verify Flask installation
RUN pip show flask

# Copy the rest of the application
COPY . .

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variable
ENV FLASK_APP=app.py

# Use python -m flask to ensure it's found
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0"]
