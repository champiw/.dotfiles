{
  model = "/models/qwen3.6-35b-a3b-mtp/Qwen3.6-35B-A3B-UD-Q4_K_M.gguf";

  spec-type = "draft-mtp";
  jinja = true;
  n-gpu-layers = 500;
  n-cpu-moe = 29;
  flash-attn = "on";

  cache-type-k = "q8_0";
  cache-type-v = "q8_0";

  ctx-size = 32768;

  threads = 7;

  batch-size = 2048;
  ubatch-size = 512;
}
