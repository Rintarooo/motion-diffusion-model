#!/bin/bash

# python -m sample.generate --model_path ./save/humanml_trans_enc_512/model000200000.pt --text_prompt "the person walked forward and is picking up his toolbox."
# python -m sample.generate --model_path ./save/humanml_trans_enc_512/model000200000.pt --text_prompt "the person raises his hands up after running forward."
python -m sample.generate --model_path ./save/humanml_trans_enc_512/model000200000.pt --text_prompt "the person jumps 2 times with his hands up and then walks forward slowly."