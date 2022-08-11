#!/bin/sh
printf "!!!  edge !!!\n"
cd /spec/Syrinx.edge/ && git --no-pager lg -6 

printf "\n!!!  not so edge !!!\n"
cd /spec/Syrinx.ApiEdge/ && git --no-pager lg -6 

printf "\n!!!  release !!!\n"
cd /spec/Syrinx.releaseCandidate/ && git --no-pager lg -6
