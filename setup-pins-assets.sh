#!/bin/zsh

source ./base.sh

declare -a DG_KEY_ASSETS=(
    'Mercado Express'
    'Rapipago'
    'Pago Fácil'
    'Cobro Express'
    'Dr Ahorro'
    'Hausbrot'
    'Cartu124'
    'Mariano Max'
    'Pintecord'
    'Carrefour'
    'Dia'
    'Libertad'
    'Axion'
    'Farmaplus'
    'Coto'
    'Farmacia Líder'
    'Red'
    'Link'
    'Diarco'
    'Maxiconsumo'
    'Cooperativa Obrera'
    'La anonima'
    'Starbucks'
    'Mostaza'
    'Bonafide'
    'Beer Markert'
    'Banelco'
)

declare -A DG_DIC_ASSETS=(
    ['Mercado Express']='cashmaps_libreriared'
    ['Rapipago']='cashmaps_rapipago'
    ['Cobro Express']='cashmaps_cobroexpress'
    ['Pago Fácil']='cashmaps_pagofacil'
    ['Dr Ahorro']='cashmaps_doctorahorro'
    ['Hausbrot']='cashmaps_hausbrot'
    ['Cartu124']='cashmaps_kiosko724'
    ['Mariano Max']='cashmaps_marianomax'
    ['Pintecord']='cashmaps_pintecord'
    ['Carrefour']='cashmaps_carrefour'
    ['Dia']='cashmaps_dia'
    ['Libertad']='cashmaps_libertad'
    ['Axion']='cashmaps_axion'
    ['Farmaplus']='cashmaps_farmaplus'
    ['Coto']='cashmaps_coto'
    ['Farmacia Líder']='cashmaps_farmacialider'
    ['Red']='cashmaps_libreriared'
    ['Link']='cashmaps_link'
    ['Diarco']='cashmaps_diarco'
    ['Maxiconsumo']='cashmaps_maxiconsumo'
    ['Cooperativa Obrera']='cashmaps_cooperativaobrera'
    ['La anonima']='cashmaps_laanonima'
    ['Starbucks']='cashmaps_starbucks'
    ['Mostaza']='cashmaps_mostaza'
    ['Bonafide']='cashmaps_bonafide'
    ['Beer Markert']='cashmaps_beermarkert'
    ['Banelco']='cashmaps_banelco'
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