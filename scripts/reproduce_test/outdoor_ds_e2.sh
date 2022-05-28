#!/bin/bash -l

SCRIPTPATH=$(dirname $(readlink -f "$0"))
PROJECT_DIR="${SCRIPTPATH}/../../"

# conda activate loftr
export PYTHONPATH=$PROJECT_DIR:$PYTHONPATH
cd $PROJECT_DIR

data_cfg_path="configs/data/megadepth_test_1500.py"
#main_cfg_path="configs/loftr/outdoor/buggy_pos_enc/loftr_ds.py"
#main_cfg_path="configs/loftr/outdoor/loftr_ds_e2.py"
#main_cfg_path="configs/loftr/outdoor/loftr_ds_e2_dense_8rot.py"
main_cfg_path="configs/loftr/outdoor/loftr_ds_e2_dense_big.py"
#ckpt_path="weights/outdoor_ds.ckpt"
#ckpt_path="weights/4rot.ckpt"
#ckpt_path="weights/8rot.ckpt"
ckpt_path="weights/4rot-big.ckpt"
dump_dir="dump/loftr_ds_outdoor_e2"
profiler_name="inference"
n_nodes=1  # mannually keep this the same with --nodes
n_gpus_per_node=-1
torch_num_workers=4
batch_size=1  # per gpu

python -u ./test.py \
    ${data_cfg_path} \
    ${main_cfg_path} \
    --ckpt_path=${ckpt_path} \
    --dump_dir=${dump_dir} \
    --gpus=${n_gpus_per_node} --num_nodes=${n_nodes} --accelerator="ddp" \
    --batch_size=${batch_size} --num_workers=${torch_num_workers}\
    --profiler_name=${profiler_name} \
    --benchmark 
    