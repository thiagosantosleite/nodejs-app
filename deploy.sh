#!/bin/bash
git pull
. ~/.profile
cd src
npm install
pm2 reload app
cd -
