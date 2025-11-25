 # -------------------------------
# # Base Image: Triton + vLLM + Python
# # -------------------------------
# FROM nvcr.io/nvidia/tritonserver:24.09-vllm-python-py3

# # Working directory
# WORKDIR /workspace

# # -------------------------------
# # Copy Your vLLM Model
# # -------------------------------
# # Copy the already downloaded Llama 3.1 8B model
# COPY vllm_workspace /workspace/vllm_workspace

# # -------------------------------
# # Copy Model Repository
# # -------------------------------
# COPY model_repository /models

# # -------------------------------
# # Install Python dependencies
# # -------------------------------
# # COPY requirements.txt .

# RUN pip install --no-cache-dir -r requirements.txt

# # ---- FIXED DEPENDENCIES (100% COMPATIBLE WITH NEMO 0.17) ----
# RUN pip install --no-cache-dir \
#     nemoguardrails==0.16.0 \
#     langchain \
#     langchain-core \
#     langchain-community \
#     langchain-ollama \
#     nest-asyncio \
#     gradio
# # -------------------------------
# # Environment Variables
# # -------------------------------
# ENV NVIDIA_VISIBLE_DEVICES=all
# ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility
# # ENV VLLM_MODEL_PATH=/workspace/vllm_workspace/Llama-3.1-8B-Instruct

# # -------------------------------
# # Expose Triton Ports
# # -------------------------------
# EXPOSE 8000 8001 8002

# # -------------------------------
# # CMD: Start Triton Server
# # -------------------------------
# CMD ["tritonserver", "--model-repository=/models", "--log-verbose=1"]
# ----------------------------------------------------------
# Base Image: Triton Server with vLLM Backend
# ----------------------------------------------------------
FROM nvcr.io/nvidia/tritonserver:24.09-vllm-python-py3

# Working directory
WORKDIR /workspace

# ----------------------------------------------------------
# Copy only model repository METADATA (NOT the model files)
# ----------------------------------------------------------
COPY model_repository /models

# ----------------------------------------------------------
# Optional: Install dependencies (you may skip this entirely)
# ----------------------------------------------------------
# COPY requirements.txt /workspace/requirements.txt
# RUN pip install --no-cache-dir -r /workspace/requirements.txt || true

# ----------------------------------------------------------
# Environment Variables
# ----------------------------------------------------------
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility
ENV VLLM_USE_NATIVE_OPS=0

# ----------------------------------------------------------
# Expose Triton Ports
# ----------------------------------------------------------
EXPOSE 8000 8001 8002

# ----------------------------------------------------------
# Start Triton Server
# ----------------------------------------------------------
CMD ["tritonserver", "--model-repository=/models", "--log-verbose=1"]
