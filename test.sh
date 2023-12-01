#!/usr/bin/env bash
docker build -t debian/dotfiles .
docker run -it debian/dotfiles
