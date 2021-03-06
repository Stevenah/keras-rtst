# Train a texturizer using a mix of training images and noise.
# usage: ./make-example-texturizer-mrf.sh EXAMPLE_STYLE PATH_TO_TRAINING_IMAGES VGG_WEIGHTS
STYLE_NAME=$1
TRAINING_DATA=$2
EVAL_DATA=$3
VGG_WEIGHTS=${4-vgg16_weights.h5}
OUTPUT_PREFIX=out/$STYLE_NAME-xfer/render
WEIGHTS_PREFIX=$STYLE_NAME
STYLE_PATH=images/$STYLE_NAME.jpg

rtst.py \
  $OUTPUT_PREFIX \
  --style-img=$STYLE_PATH \
  --train \
  --max-width=${MAX_WIDTH-128} \
  --content-w=${CONTENT_W-0.5} \
  --content-layers=${CONTENT_LAYERS-conv4_2} \
  --style-w=${STYLE_W-0.0} \
  --mrf-w=${MRF_W-1.0} \
  --mrf-layers=${MRF_LAYERS-conv4_2} \
  --weights-prefix=$WEIGHTS_PREFIX \
  --vgg-weights=$VGG_WEIGHTS \
  --train-data=$TRAINING_DATA \
  --eval-data=$EVAL_DATA \
  --batch-size=1 \
  --ignore --auto-save-weights
