#!/bin/zsh

#######################################################################################################################
# Base arrays | exports | and | methods

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

export DG_PLATFORM_IOS="ios"
export DG_PLATFORM_AND="android"

export DG_WORKING_DIR="$(pwd)/deploy"
export DG_ASSETS_DIR="$(pwd)/assets"
export DG_ODR_RESULT_LOG="$(pwd)/result.log"

export DG_UPLOAD_ASSET_DIR="$TMPDIR.deploy.dg"

fetch-env () {
    echo "DG Envs Vars:"
    env | grep "DG"
}