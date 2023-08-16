# https://qiita.com/namakemono/items/c963e75e0af3f7eed732
# FILE_ID=17eqDPTs0Sv83Q7e-IWox_69bCbiXUzPU # ここには自分がダウンロードしたいファイルIDを入れる
# FILE_ID=1PE0PK8e5a5j-7-Xhs5YET5U5pGh0c821
# FILE_NAME=humanml_trans_enc_512.zip
FILE_ID=1tX79xk0fflp07EZ660Xz1RAFE33iEyJR
#1DSaKqWX2HlwBtVH5l7DdW96jeYUIXsOP#1INYlGA76ak_cKGzvpOV2Pe6RkYTlXTW2
FILE_NAME=kit.zip
#t2m.zip#smpl.zip
curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=${FILE_ID}" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"  
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=${FILE_ID}" -o ${FILE_NAME}