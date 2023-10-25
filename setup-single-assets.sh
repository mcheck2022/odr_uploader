#!/bin/zsh

source ./base.sh

declare -a DG_KEY_ASSETS=(
    'Pin'
    'Carrefour2'
    'Official Stores'
    'Return'
    'none'
)

declare -A DG_DIC_ASSETS=(
    ['Pin']='cashback_landing_carrefour_pin'
    ['Carrefour2']='cashback_carrefour_header_icon'
    ['Official Stores']='cashback_congrats_icon_success'
    ['Return']='moneyin-hub-cashback-icon'
    ['none']='cashback_congrats_icon_error'
)

#######################################################################################################################
# ODR_TYPE = create | update
export ODR_TYPE='create'
# SKIP_REAL_ODR_UPLOAD = yes | no
export SKIP_REAL_ODR_UPLOAD='yes'

