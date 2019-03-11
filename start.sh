#!/bin/bash

rm -f /var/run/fail2ban/*
service fail2ban start
tailf /var/log/fail2ban.log
