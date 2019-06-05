#! /bin/bash

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    --style)
    STYLE="$2"
    shift # past argument
    shift # past value
    ;;
    --end)
    END="$2"
    shift # past argument
    shift # past value
    ;;
    --start)
    START="$2"
    shift # past argument
    shift # past value
    ;;
    --cuda)
    CUDA="$2"
    shift # past argument
    shift # past value
    ;;
    --dir)
    DIR="${2:-tub_05_25_centerlane}"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

OUTPUT_DIR=style_output_${STYLE}_${DIR}
mkdir ${OUTPUT_DIR}

for i in $(seq $START $END); do
python main.py eval --content-image ${DIR}/${i}_cam-image_array_.jpg --style-image images/21styles/${STYLE}.jpg --model models/21styles.model --content-size 160 --cuda ${CUDA} --output-image ${OUTPUT_DIR}/${i}_cam-image_array_.jpg
echo ${i}+${STYLE}+${DIR}
done
