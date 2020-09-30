#!/usr/bin/expect -f
set timeout -1

spawn /McMyAdmin/MCMA2_Linux_x86_64 -setpass $::env(MCMA_PASSWORD) -configonly
expect "y/n"
send -- "y"

expect eof
