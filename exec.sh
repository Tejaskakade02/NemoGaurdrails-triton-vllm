docker run --gpus all -p 8000:8000 -p 8001:8001 -p 8002:8002 -v "$(pwd)/model_repository:/models" -v "$(pwd)/vllm_workspace:/workspace/vllm_workspace" triton-vllm-guardrails
