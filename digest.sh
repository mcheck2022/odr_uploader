#!/bin/zsh

echo "DG: digest.sh Args are: $@"

export DG_PLATFORM_IOS="ios"
export DG_PLATFORM_AND="android"

export DG_WORKING_DIR="$(pwd)/deploy"
export DG_ASSETS_DIR="$(pwd)/assets"
export DG_ODR_RESULT_LOG="$(pwd)/result.log"

export DG_UPLOAD_ASSET_DIR="$TMPDIR.deploy.dg"

source ./setup-single-assets.sh

#######################################################################################################################
# COMMAND PRIVATE BEGIN

fetch-env () {
    echo "DG Envs Vars:"
    env | grep "DG"
}

fetch-assets-zips () {
    echo "DG fetch-assets-zips at: $DG_ASSETS_DIR"

    find $DG_ASSETS_DIR -maxdepth 1 -mindepth 1 -type f | while IFS= read -r d; do
        if [[ $d == *".zip" ]]
        then
            echo "DG Zip Asset found $d"
            unzip $d -d $DG_UPLOAD_ASSET_DIR 2> /dev/null
        fi
    done

    open $DG_UPLOAD_ASSET_DIR
}

setup_dg () {
    rm -rf $DG_WORKING_DIR 2> /dev/null
    rm -rf $DG_UPLOAD_ASSET_DIR 2> /dev/null
    mkdir $DG_WORKING_DIR 2> /dev/null

    rm -rf $DG_ODR_RESULT_LOG 2> /dev/null
    echo "Result of Log:" >> $DG_ODR_RESULT_LOG
    echo "Assets unziped at: $DG_WORKING_DIR" >> $DG_ODR_RESULT_LOG

    fetch-assets-zips
}

upload-odr-create-images () {
    echo "DG upload-odr-create-images with argument at: $1"
    find $1 -maxdepth 1 -mindepth 1 -type d | while IFS= read -r d; do
        echo "odr $ODR_TYPE image --directory $d"
        RESULTLOG=$(odr $ODR_TYPE image --directory $d)
        echo $RESULTLOG >> $DG_ODR_RESULT_LOG
    done
}


upload-directories () {
    echo "DG upload-directories at: $DG_WORKING_DIR"

    find $DG_WORKING_DIR -maxdepth 1 -mindepth 1 -type d | while IFS= read -r d; do
        upload-odr-create-images $d
    done

    open $DG_WORKING_DIR
}

digest-assets-android-dimensions() {
    for DIM_POINT in $DG_ANDROID_DIMS
    do
        ANDROID_DIM_POINT_PATH="$1/$DIM_POINT"
        # echo "DG ANDROID_DIM_POINT_PATH: $ANDROID_DIM_POINT_PATH"

        mkdir $ANDROID_DIM_POINT_PATH 2> /dev/null

        UPLOAD_ASSET_PATH=$(find $DG_UPLOAD_ASSET_DIR -name "$3*$DIM_POINT.png")
        # echo "DG UPLOAD_ASSET_PATH $UPLOAD_ASSET_PATH"

        FILENAME_PATH="$ANDROID_DIM_POINT_PATH/$2.png"

        cp $UPLOAD_ASSET_PATH $FILENAME_PATH
    done
}


digest-assets-ios-dimensions() {
    for IOS_SIZE in $DG_IPHONE_DIM_TYPES
    do
        IOS_IOS_SIZE_PATH="$1/$IOS_SIZE"
        #echo "DG IOS_IOS_SIZE_PATH $IOS_IOS_SIZE_PATH"

        UPLOAD_ASSET_PATH=$(find $DG_UPLOAD_ASSET_DIR -name "$3*$IOS_SIZE")
        #echo "DG UPLOAD_ASSET_PATH_IOS: $UPLOAD_ASSET_PATH"

        FILENAME_PATH="${1}/${2}${IOS_SIZE}"

        cp $UPLOAD_ASSET_PATH $FILENAME_PATH
    done
}

digest-assets-keys () {
    for KEY in $DG_KEY_ASSETS
    do
        DIGEST_ASSET="${DG_DIC_ASSETS[$KEY]}"
        DEPLOY_ASSET_PATH="$DG_WORKING_DIR/$DIGEST_ASSET"
        # echo "DG Asset Dic: $KEY = $DIGEST_ASSET | PATH: $DEPLOY_ASSET_PATH"

        rm -rf $DEPLOY_ASSET_PATH 2> /dev/null
        mkdir $DEPLOY_ASSET_PATH 2> /dev/null


        DEPLOY_IOS_ASSET_PATH="${DEPLOY_ASSET_PATH}/${DIGEST_ASSET}_$DG_PLATFORM_IOS"
        DEPLOY_AND_ASSET_PATH="${DEPLOY_ASSET_PATH}/${DIGEST_ASSET}_$DG_PLATFORM_AND"

        mkdir $DEPLOY_IOS_ASSET_PATH 2> /dev/null
        mkdir $DEPLOY_AND_ASSET_PATH 2> /dev/null

        digest-assets-ios-dimensions $DEPLOY_IOS_ASSET_PATH $DIGEST_ASSET $KEY
        digest-assets-android-dimensions $DEPLOY_AND_ASSET_PATH $DIGEST_ASSET $KEY
    done
}


fetch-env
setup_dg

digest-assets-keys
upload-directories
