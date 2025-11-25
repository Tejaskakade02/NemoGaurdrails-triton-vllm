# NemoGaurdrails-triton-vllm

# Project Structure

```
project_root/
│
├── model_repository/
│   └── guardrails/
│       ├── config.pbtxt
│       └── 1/
│           └── rails/
│               ├── config.yml
│               └── rails.co
│
└── vllm_workspace/
    └── Llama-3.2-1B-Instruct/   ← downloaded model here
```

# Download the LLM Model

Run inside project root:

```
huggingface-cli download meta-llama/Llama-3.2-1B-Instruct \
  --local-dir vllm_workspace/Llama-3.2-1B-Instruct \
  --local-dir-use-symlinks False
```

(Replace with any model you want to use.)

# Build Docker Image

```
docker build -t triton-vllm-guardrails .
```

# Start Triton Server

Run:

```
bash exec.sh
```

(Ensure `exec.sh` contains your final docker run command.)

# Health Check

```
curl http://localhost:8000/v2/health/ready
```

# Test Inference

```
curl -X POST http://localhost:8000/v2/models/guardrails/infer \
  -d '{"inputs":[{"name":"text_input","shape":[1],"datatype":"BYTES","data":["hello"]}]}'
```

# Full Test Suite

```
python test_guardrails_full.py
```

# Notes

* LLM weights remain outside the container and are mounted via volume.
* Guardrails are applied using the prompt templates in `rails.co` and `config.yml`.
* Triton serves the model through the **vLLM backend** for GPU-accelerated inference.
