master_script="./scripts/common/master_script.py"
output_dir="results/specom2018"

export PYTHONPATH="$(pwd)/scripts/util:$PYTHONPATH"

$master_script --output-dir $output_dir --num-folds 5 --gen-folds --no-train-master --no-train-folds --no-predict --no-train-rpl --no-eval
for i in {0..9}; do
    $master_script --output-dir $output_dir --output-id ff_$i          --num-folds 5 --network-spec "-n ff          -l 8 -u 2048 -a relu --splice 5 -d 0.2" -o momentumsgd -b 256 1024 2048 --lr 1e-2 4e-3 1e-4
    $master_script --output-dir $output_dir --output-id lstm_$i        --num-folds 5 --network-spec "-n lstm        -l 4 -u 1024 --timedelay 5 -d 0.2" -o adam momentumsgd -b 512 128 --lr 1e-2 1e-3 1e-4 1e-5
    $master_script --output-dir $output_dir --output-id gru_$i         --num-folds 5 --network-spec "-n gru         -l 4 -u 1024 --timedelay 5 -d 0.2" -o adam momentumsgd -b 512 128 --lr 1e-2 1e-3 1e-4 1e-5
    $master_script --output-dir $output_dir --output-id zoneoutlstm_$i --num-folds 5 --network-spec "-n zoneoutlstm -l 4 -u 1024 --timedelay 5 -d 0.2" -o adam momentumsgd -b 512 128 --lr 1e-2 1e-3 1e-4 1e-5
done