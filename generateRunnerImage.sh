echo "Building the Docker image"
docker build -t e2e .
echo "Saving the Docker image"
docker save e2e > runner/e2e.tar