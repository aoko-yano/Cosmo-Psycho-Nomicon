docker build -t updator -f Dockerfile.update .
docker run --rm -v "%~dp0\materials:/app" updator