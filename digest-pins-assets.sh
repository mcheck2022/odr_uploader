#!/bin/zsh

echo "DG: digest.sh Args are: $@"

export DG_PLATFORM_IOS="ios"
export DG_PLATFORM_AND="android"

export DG_WORKING_DIR="$(pwd)/deploy"
export DG_ASSETS_DIR="$(pwd)/assets"
export DG_ODR_RESULT_LOG="$(pwd)/result.log"

export DG_UPLOAD_ASSET_DIR="$TMPDIR.deploy_dg"

source ./setup-pins-assets.sh

#######################################################################################################################
# COMMAND PRIVATE BEGIN

fetch-env () {
    echo "DG Envs Vars:"
    env | grep "DG"
}

fetch-assets-zips () {
    echo "DG fetch-assets-zips at: $DG_ASSETS_DIR"

    find $DG_ASSETS_DIR -maxdepth 3 -mindepth 2 -type f | while IFS= read -r d; do
        if [[ $d == *".zip" ]]
        then
            #echo "DG Zip Asset found $d"
            for DG_TYPE_SITE in $DG_TYPE_SITES
            do
                for DG_PIN_TYPE in $DG_PIN_TYPES
                do
                     if [[ $d == *\/$DG_TYPE_SITE\/$DG_PIN_TYPE\/*".zip" ]]
                    then
                        echo "DG Zip Asset found $d"
                        echo "found with site '$DG_TYPE_SITE' and type: '$DG_PIN_TYPE'"
                        unzip $d -d $DG_UPLOAD_ASSET_DIR/$DG_TYPE_SITE/$DG_PIN_TYPE 2> /dev/null
                    fi
                done
            done
        fi
    done

    find $DG_UPLOAD_ASSET_DIR -type d -empty -delete
}

setup_dg () {
    rm -rf $DG_WORKING_DIR 2> /dev/null
    rm -rf $DG_UPLOAD_ASSET_DIR 2> /dev/null

    mkdir $DG_UPLOAD_ASSET_DIR 2> /dev/null

    for DG_TYPE_SITE in $DG_TYPE_SITES
    do
        mkdir "$DG_UPLOAD_ASSET_DIR/$DG_TYPE_SITE" 2> /dev/null
        for DG_PIN_TYPE in $DG_PIN_TYPES
        do
            mkdir "$DG_UPLOAD_ASSET_DIR/$DG_TYPE_SITE/$DG_PIN_TYPE" 2> /dev/null
        done
    done

    mkdir $DG_WORKING_DIR 2> /dev/null

    rm -rf $DG_ODR_RESULT_LOG 2> /dev/null
    echo "Result of Log:" >> $DG_ODR_RESULT_LOG
    echo "Assets unziped at: $DG_WORKING_DIR" >> $DG_ODR_RESULT_LOG
}

upload-odr-create-images () {
    echo "DG upload-odr-create-images with argument at: $1"
    echo "odr $ODR_TYPE image --directory $d"

    if [[ $SKIP_REAL_ODR_UPLOAD == "no" ]]
    then
        RESULTLOG=$(odr $ODR_TYPE image --directory $d)
        echo $RESULTLOG
        echo $RESULTLOG >> $DG_ODR_RESULT_LOG
    fi
}

upload-directories-android () {
    #echo "DG upload-directories at: $1"

    find $1 -maxdepth 2 -mindepth 2 -type d | while IFS= read -r d; do
        # echo "aca: $d"
        upload-odr-create-images $d
    done
}

upload-directories-ios () {
    #echo "-->  DG upload-directories at: $1"

    find $1 -maxdepth 3 -mindepth 2 -type d | while IFS= read -r d; do
        #echo "final aca ios: $d"
        upload-odr-create-images $d
    done
}

uploader () {
    #echo "DG upload-directories at: $DG_WORKING_DIR"

    find $DG_WORKING_DIR -maxdepth 2 -mindepth 2 -type d | while IFS= read -r d; do
        if [[ $d == *"_ios" ]]
        then
            #echo "--> ios: $d"
            upload-directories-ios $d
        fi

        if [[ $d == *"_android" ]]
        then
            #echo "android: $d"
            upload-directories-android $d
        fi
    done
}

digest-assets-android-dimensions() {
    #echo "digest-assets-android-dimensions: $@"

    for DIM_POINT in $DG_ANDROID_DIMS
    do
        for DG_TYPE_SITE in $DG_TYPE_SITES
        do
            for DG_PIN_TYPE in $DG_PIN_TYPES
            do
                PATH_SEARCH="$DG_UPLOAD_ASSET_DIR/$DG_TYPE_SITE/$DG_PIN_TYPE"
                LOCATE="$3*$DIM_POINT.png"
                #echo "PATH_SEARCH: $PATH_SEARCH"
                #echo "LOCATE FILE PATTERN: $LOCATE"

                UPLOAD_ASSET_PATH=$(find $PATH_SEARCH -name $LOCATE)
                #echo "DG UPLOAD_ASSET_PATH Android: $UPLOAD_ASSET_PATH"

                DIM_NAME=$(echo "$DIM_POINT" | sed "s/drawable-/-/")
                # 'drawable-ldpi'


                ROOT_ANDROID_SITE="${1}/${DG_TYPE_SITE}/${DG_PIN_TYPE}"
                ROOT_ANDROID_DIM_SITE="$ROOT_ANDROID_SITE/$DIM_POINT"

                mkdir "$ROOT_ANDROID_DIM_SITE"

                EXTENSION_NAME=$DG_DIC_TRANSLATE_ASSETS[$DG_PIN_TYPE]
                FILENAME_PATH="${ROOT_ANDROID_DIM_SITE}/${2}${EXTENSION_NAME}.png"
                #echo "DG FILENAME_PATH: $FILENAME_PATH"

                cp "$UPLOAD_ASSET_PATH" "$FILENAME_PATH" 2>/dev/null || :
            done
        done
    done
}


digest-assets-ios-dimensions() {
    echo "digest-assets-ios-dimensions: $@"

    for IOS_SIZE in $DG_IPHONE_DIM_TYPES
    do
        for DG_TYPE_SITE in $DG_TYPE_SITES
        do
            for DG_PIN_TYPE in $DG_PIN_TYPES
            do
                PATH_SEARCH="$DG_UPLOAD_ASSET_DIR/$DG_TYPE_SITE/$DG_PIN_TYPE"
                LOCATE="$3*$IOS_SIZE"
                #echo "PATH_SEARCH: $PATH_SEARCH"
                #echo "LOCATE FILE PATTERN: $LOCATE"

                UPLOAD_ASSET_PATH=$(find $PATH_SEARCH -name $LOCATE)
                #echo "DG UPLOAD_ASSET_PATH IOS: $UPLOAD_ASSET_PATH"

                EXTENSION_NAME=$DG_DIC_TRANSLATE_ASSETS[$DG_PIN_TYPE]
                FILENAME_PATH="${1}/${DG_TYPE_SITE}/${DG_PIN_TYPE}/${2}${EXTENSION_NAME}${IOS_SIZE}"
                # echo "DG FILENAME_PATH: $FILENAME_PATH"

                cp "$UPLOAD_ASSET_PATH" "$FILENAME_PATH" 2>/dev/null || :
            done
        done
    done
}

digest-assets-keys () {
    for KEY in $DG_KEY_ASSETS
    do
        DIGEST_ASSET="${DG_DIC_ASSETS[$KEY]}"
        DEPLOY_ASSET_PATH="$DG_WORKING_DIR/$DIGEST_ASSET"

        #echo "DG Asset Dic KEY: $KEY  | DIGEST_ASSET: $DIGEST_ASSET | DEPLOY_ASSET_PATH: $DEPLOY_ASSET_PATH"

        rm -rf $DEPLOY_ASSET_PATH 2> /dev/null
        mkdir $DEPLOY_ASSET_PATH 2> /dev/null

        for DG_TYPE_SITE in $DG_TYPE_SITES
        do
            for DG_PIN_TYPE in $DG_PIN_TYPES
            do

                DEPLOY_IOS_ASSET_PATH="${DEPLOY_ASSET_PATH}/${DIGEST_ASSET}_$DG_PLATFORM_IOS"
                DEPLOY_AND_ASSET_PATH="${DEPLOY_ASSET_PATH}/${DIGEST_ASSET}_$DG_PLATFORM_AND"

                mkdir $DEPLOY_IOS_ASSET_PATH 2> /dev/null
                mkdir $DEPLOY_IOS_ASSET_PATH/$DG_TYPE_SITE 2> /dev/null
                mkdir $DEPLOY_IOS_ASSET_PATH/$DG_TYPE_SITE/$DG_PIN_TYPE 2> /dev/null

                mkdir $DEPLOY_AND_ASSET_PATH 2> /dev/null
                mkdir $DEPLOY_AND_ASSET_PATH/$DG_TYPE_SITE 2> /dev/null
                mkdir $DEPLOY_AND_ASSET_PATH/$DG_TYPE_SITE/$DG_PIN_TYPE 2> /dev/null
            done
        done

        digest-assets-ios-dimensions $DEPLOY_IOS_ASSET_PATH $DIGEST_ASSET $KEY
        digest-assets-android-dimensions $DEPLOY_AND_ASSET_PATH $DIGEST_ASSET $KEY

        find $DEPLOY_ASSET_PATH -type d -empty -delete
    done
}


fetch-env
setup_dg
fetch-assets-zips

digest-assets-keys

uploader

open $DG_WORKING_DIR
open $DG_UPLOAD_ASSET_DIR