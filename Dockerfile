# Preswald requires Docker to run
FROM docker:stable-dind

# Install Python
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    curl

# Set the working directory inside the container
WORKDIR /app

# Copy the contents of the repository into the container
COPY . .

# Install required Python packages
RUN pip install --no-cache-dir preswald plotly pandas

# Default command to run
CMD ["preswald", "deploy"]
