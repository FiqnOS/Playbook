@echo off
powercfg -import "C:\Windows\APIs\POW\fiqn.pow"
powercfg /setactive 115e7fd6-e9b1-4a76-9285-a642348a675c
powercfg /setactive scheme_current
powercfg -h off
