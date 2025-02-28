#!/bin/bash
# change the dataset_path to your own path

root_dir=. # TravelUAV directory
model_dir=$root_dir/Model/LLaMA-UAV


CUDA_VISIBLE_DEVICES=0 python -u $root_dir/src/vlnce_src/dagger.py \
    --run_type collect \
    --collect_type dagger \
    --name TravelLLM \
    --gpu_id 4 \
    --simulator_tool_port 25000 \
    --DDP_MASTER_PORT 80002 \
    --batchSize 1 \
    --dagger_it 1 \
    --dagger_p 0.4 \
    --maxWaypoints 200 \
    --activate_maps NYCEnvironmentMegapa \
    --dataset_path /mnt/data5/airdrone/dataset/replay_data_log0.1_image0.5/ \
    --dagger_save_path $root_dir/data/dagger_data \
    --model_path $model_dir/work_dirs/llama-vid-7b-pretrain-224-uav-full-data-lora32 \
    --model_base $model_dir/model_zoo/vicuna-7b-v1.5 \
    --vision_tower $model_dir/model_zoo/LAVIS/eva_vit_g.pth \
    --image_processor $model_dir/llamavid/processor/clip-patch14-224 \
    --traj_model_path $model_dir/work_dirs/traj_predictor_bs_128_drop_0.1_lr_5e-4 \
    --train_json_path $root_dir/data/uav_dataset/trainset.json \
    --map_spawn_area_json_path $root_dir/data/meta/map_spawnarea_info.json \
    --object_name_json_path $root_dir/data/meta/object_description.json \
    --groundingdino_config $root_dir/src/model_wrapper/utils/GroundingDINO/groundingdino/config/GroundingDINO_SwinT_OGC.py \
    --groundingdino_model_path $root_dir/src/model_wrapper/utils/GroundingDINO/groundingdino_swint_ogc.pth


