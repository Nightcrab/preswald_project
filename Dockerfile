# Use an official Python 3.12 image as the base
FROM python:3.12

# Set the working directory inside the container
WORKDIR /app

# Install dependencies for Docker
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Add Docker's official GPG key and repository
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | tee /etc/apt/trusted.gpg.d/docker.asc
RUN echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# Install Docker
RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io

# Copy the contents of the repository into the container
COPY . .

# Install required Python packages
RUN pip install --no-cache-dir preswald plotly pandas

# Default command to run
CMD ["preswald", "deploy"]
