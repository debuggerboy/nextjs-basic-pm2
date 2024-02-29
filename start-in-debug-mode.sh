#!/bin/bash
docker run --name test --rm -it -v ./rescue:/usr/bin/rescue --entrypoint rescue  -p 3000:3000 localhost/local/library/nextjs:latest
