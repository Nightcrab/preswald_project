# Use an official Python 3.12 image as the base
FROM python:3.12

# Set the working directory inside the container
WORKDIR /app

# Copy the contents of the repository into the container
COPY . .

# Install required Python packages
RUN pip install --no-cache-dir preswald plotly

# Default command to run
CMD ["preswald", "deploy"]
