# Use Docker-in-Docker image (based on Alpine)
FROM docker:stable-dind

# Install dependencies
RUN apk add --no-cache \
    python3 \
    py3-pip \
    curl

# Install required Python packages
RUN pip3 install --no-cache-dir preswald plotly pandas

# Set the working directory inside the container
WORKDIR /app

# Copy the contents of the repository into the container
COPY . .

# Default command to run
CMD ["preswald", "deploy"]
