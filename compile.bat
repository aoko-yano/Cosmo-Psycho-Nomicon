docker build -t compiler -f Dockerfile.compile .
docker run --rm -v "%~dp0\materials:/app" compiler