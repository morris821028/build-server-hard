#!/bin/bash

./mapper.py <avg.in | sort -k1,1 | ./combiner.py | ./reducer.py
./mapper <avg.in | sort -k1,1 | ./combiner | ./reducer
