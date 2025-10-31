FROM python:3.11-slim

WORKDIR /app

# System deps just for building wheels
RUN apt-get update \
 && apt-get install -y --no-install-recommends gcc python3-dev \
 && rm -rf /var/lib/apt/lists/*

# Upgrade pip because 24.0 is prehistoric now
RUN python -m pip install --upgrade pip

# Install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Your app
COPY app.py .
COPY model.pkl .

EXPOSE 5000
CMD ["python", "app.py"]
