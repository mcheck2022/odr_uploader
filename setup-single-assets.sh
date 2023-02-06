#!/bin/zsh

declare -a DG_KEY_ASSETS=(
    'TmpOdrTest'
)

declare -A DG_DIC_ASSETS=(
    ['TmpOdrTest']='mch_tmp'
)

#######################################################################################################################
# ODR_TYPE = create | replace
export ODR_TYPE='create'
# SKIP_REAL_ODR_UPLOAD = yes | no
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
