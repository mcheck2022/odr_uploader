#!/bin/zsh

source ./base.sh

declare -a DG_KEY_ASSETS=(
    'Dia'
)
declare -A DG_DIC_ASSETS=(
    ['Dia']='test_cashmaps_dia'
)

#######################################################################################################################
# ODR_TYPE = create | update
export ODR_TYPE='update'
# SKIP_REAL_ODR_UPLOAD = yes | no
export SKIP_REAL_ODR_UPLOAD='yes'


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
    'Pines Selecionados'
    'Pines Selecionados - No Disponible'
    'Thumb Listado'
    'Thumb Listado - No Disponible'
)

declare -A DG_DIC_TRANSLATE_ASSETS=(
    ['Pines Default']='_icon_pin'
    ['Pines Default - No Disponible']='_icon_pin_notavailable'
    ['Pines Selecionados']='_icon_pin_selected'
    ['Pines Selecionados - No Disponible']='_icon_pin_selected_notavailable'
    ['Thumb Listado']='_icon'
    ['Thumb Listado - No Disponible']='_icon_notavailable'
)