docker build -t compiler -f Dockerfile.compile .
docker run --rm -v "%~dp0:/app" compiler

del materials\tex\*.bak