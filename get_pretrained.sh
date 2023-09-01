# https://qiita.com/namakemono/items/c963e75e0af3f7eed732

# FILE_ID="1PE0PK8e5a5j-7-Xhs5YET5U5pGh0c821"
PRETRAINED_DIR="./save"
# FILE_NAME=$PRETRAINED_DIR"/humanml_trans_enc_512.zip"

SMPL_DIR="./body_models/smpl"

file_ids=(
    # "1tX79xk0fflp07EZ660Xz1RAFE33iEyJR"
    # "1DSaKqWX2HlwBtVH5l7DdW96jeYUIXsOP"
    "1INYlGA76ak_cKGzvpOV2Pe6RkYTlXTW2"
    "1PE0PK8e5a5j-7-Xhs5YET5U5pGh0c821"
)

file_names=(
#   "kit.zip"
#   "t2m.zip"
  $SMPL_DIR"/smpl.zip"
  $PRETRAINED_DIR"/humanml_trans_enc_512.zip"
)

if [ ! -d "$PRETRAINED_DIR" ]; then
  mkdir "$PRETRAINED_DIR"
  echo "'$PRETRAINED_DIR' is made"
else
  echo "$PRETRAINED_DIR' already exists"
fi

if [ ! -d "$SMPL_DIR" ]; then
  mkdir -p "$SMPL_DIR"
  echo "'$SMPL_DIR' is made"
else
  echo "$SMPL_DIR' already exists"
fi


# single file
curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=${FILE_ID}" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"  
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=${FILE_ID}" -o ${FILE_NAME}

# multiple files
# for ((i=0; i<${#file_names[@]}; i++)); do
for file_name in "${file_names[@]}"; do
  echo "$file_name"
  FILE_NAME=${file_names[i]}
  FILE_ID=${file_ids[i]}
  curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=${FILE_ID}" > /dev/null
  CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"  
#   curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=${FILE_ID}" -o ${PRETRAINED_DIR}/${FILE_NAME}
  curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=${FILE_ID}" -o ${FILE_NAME}
  unzip $file_name
  # you might need to mv directory
  rm $file_name
done