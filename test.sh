#!/bin/bash

top -bn1 | grep "Cpu(s)"

top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}'  

top -bn1 | grep "Cpu(s)" | cut -d "," -f4 | xargs | cut -d " " -f1 | awk '{print 100 - $1"%"}'

