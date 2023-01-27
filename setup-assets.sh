#!/bin/zsh

declare -a DG_KEY_ASSETS
declare -A DG_DIC_ASSETS


DG_KEY_ASSETS=(
    'Axion'
    'Bonafide'
    '7-eleven'
    'Mariano Max'
)

cashmaps_7eleven_icon vs 7-eleven
DG_DIC_ASSETS=(
    ['Axion']='cashmaps_libreriared_icon'
    ['Bonafide']='cashmaps_bonafide_icon'
    ['7-eleven']='cashmaps_7eleven_icon'
    ['Mariano Max']='cashmaps_marianomax_icon'
)

#######################################################################################################################
# ODR_TYPE = create | replace
# SKIP_REAL_ODR_UPLOAD = yes | no
export ODR_TYPE='create'
export SKIP_REAL_ODR_UPLOAD='yes'

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
