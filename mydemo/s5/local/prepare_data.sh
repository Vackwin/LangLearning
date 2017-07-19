#!/bin/bash

mkdir -p data/local
local=`pwd`/local
scripts=`pwd`/scripts

export PATH=$PATH:`pwd`/../../../tools/irstlm/bin

echo "Preparing train and test data"

train_base_name=train_mydemo
test_base_name=test_mydemo
waves_dir=$1

ls -1 $waves_dir > data/local/waves_all.list

cd data/local

../../local/create_mydemo_waves_test_train.pl waves_all.list waves.test waves.train

../../local/create_mydemo_wav_scp.pl ${waves_dir} waves.test > ${test_base_name}_wav.scp

../../local/create_mydemo_wav_scp.pl ${waves_dir} waves.train > ${train_base_name}_wav.scp

../../local/create_mydemo_txt.pl ../../waves.info waves.test > ${test_base_name}.txt

../../local/create_mydemo_txt.pl ../../waves.info waves.train > ${train_base_name}.txt

cd ../..

# This stage was copied from WSJ example
for x in train_mydemo test_mydemo; do 
  mkdir -p data/$x
  cp data/local/${x}_wav.scp data/$x/wav.scp
  cp data/local/$x.txt data/$x/text
  cat data/$x/text | awk '{printf $1;printf " ";split($1,b,"_");print b[1];}' > data/$x/utt2spk
  utils/utt2spk_to_spk2utt.pl <data/$x/utt2spk >data/$x/spk2utt
done

