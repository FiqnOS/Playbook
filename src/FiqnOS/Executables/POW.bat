@echo off
powercfg -import "C:\Windows\Users\Default\Post-Install\Tweaks\fiqn.pow" 115e7fd6-e9b1-4a76-9285-a642348a675c
powercfg /setactive 115e7fd6-e9b1-4a76-9285-a642348a675c
powercfg /setactive scheme_current
powercfg -h off
