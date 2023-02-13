#!/bin/zsh

source ./base.sh

declare -a DG_KEY_ASSETS=(
    'Beer Market'
)

declare -A DG_DIC_ASSETS=(
    ['Beer Market']='mch_tmp_test2'
)

#######################################################################################################################
# ODR_TYPE = create | update
export ODR_TYPE='create'
# SKIP_REAL_ODR_UPLOAD = yes | no
export SKIP_REAL_ODR_UPLOAD='yes'

