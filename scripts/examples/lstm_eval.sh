#!/usr/bin/bash
# Evaluating on Both Development and Test Data
./scripts/common/master_script.py --output-dir example_out --output-id example_lstm_eval --network-spec "-n ff -l 8 -u 2048 -a relu --splice 5 -d 0.2" -o adam momentumsgd -b 512 128 --lr 0 1e-3 1e-4 1e-5 --eval-data dev test