#!/bin/zsh

declare -a DG_KEY_ASSETS=(
    'Red'
    'Bonafide'
)

declare -A DG_DIC_ASSETS=(
    ['Red']='mch_tmp12_red'
    ['Bonafide']='mch_tmp12_bonafide'
)


#######################################################################################################################
# ODR_TYPE = create | replace
export ODR_TYPE='create'
# SKIP_REAL_ODR_UPLOAD = yes | no
export SKIP_REAL_ODR_UPLOAD='no'


#######################################################################################################################
# DONT EDIT BELOW THIS POINT
# IOS dimensions && Android Dimensions


declare -a DG_TYPE_SITES=(
    'MLA'
    'MLM'
    'MLB'
    'MCO'
    'MLC'
)

declare -a DG_PIN_TYPES=(
    'Pines Default'
    'Pines Default - No Disponible'
    'Pines  Selecionados'
    'Pines Selecionados - No Disponible'
    'Thumb Listado'
    'Thumb Listado - No Disponible'
)

declare -A DG_DIC_TRANSLATE_ASSETS=(
    ['Pines Default']='_icon_pin'
    ['Pines Default - No Disponible']='_icon_pin_notavailable'
    ['Pines  Selecionados']='_icon_pin_selected'
    ['Pines Selecionados - No Disponible']='_icon_pin_selected_notavailable'
    ['Thumb Listado']='_icon'
    ['Thumb Listado - No Disponible']='_icon_notavailable'
)


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
