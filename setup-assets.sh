#!/bin/zsh

declare -a DG_KEY_ASSETS
declare -A DG_DIC_ASSETS


DG_KEY_ASSETS=(
    'Axion'
    'Bonafide'
)


DG_DIC_ASSETS=(
    ['Axion']='cashout_tmp4_axion_icon_pin'
    ['Bonafide']='cashout_tmp4_bonafide_icon_pin'
)

#######################################################################################################################
# ODR_TYPE = create | replace
export ODR_TYPE='create'

#######################################################################################################################
# DONT EDIT BELOW THIS POINT
# IOS dimensions && Android Dimensions

declare -a DG_IPHONE_DIM_TYPES=(
    '@1x.png'
    '@2x.png'
    '@3x.png'
)

declare -a DG_ANDROID_DIMS=(
    'drawable-ldpi'
    'drawable-hdpi'
    'drawable-mdpi'
    'drawable-xhdpi'
    'drawable-xxhdpi'
    'drawable-xxxhdpi'
)
