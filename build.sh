#!/bin/bash

set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <platform>"
    echo "Available platforms: iOS, tvOS, watchOS, visionOS, macOS"
    exit 1
fi

PLATFORM_ARG=$1
SCHEME_NAME="swift-sfsymbols-artifacts"
FRAMEWORK_NAME="SFSymbols"
DERIVED_DATA_DIR="DerivedData"
OUTPUT_DIR="Artifacts"


# Clean up previous builds
rm -rf "${DERIVED_DATA_DIR}" "${OUTPUT_DIR}"
mkdir -p "${DERIVED_DATA_DIR}" "${OUTPUT_DIR}"

DEVICE_PLATFORM=""
SIMULATOR_PLATFORM=""

case $PLATFORM_ARG in
    "iOS")
        DEVICE_PLATFORM="iOS"
        SIMULATOR_PLATFORM="iOS Simulator"
        ;;
    "tvOS")
        DEVICE_PLATFORM="tvOS"
        SIMULATOR_PLATFORM="tvOS Simulator"
        ;;
    "watchOS")
        DEVICE_PLATFORM="watchOS"
        SIMULATOR_PLATFORM="watchOS Simulator"
        ;;
    "visionOS")
        DEVICE_PLATFORM="visionOS"
        SIMULATOR_PLATFORM="visionOS Simulator"
        ;;
    "macOS")
        DEVICE_PLATFORM="macOS"
        ;;
    *)
        echo "Invalid platform: $PLATFORM_ARG"
        echo "Available platforms: iOS, tvOS, watchOS, visionOS, macOS"
        exit 1
        ;;
esac

FRAMEWORK_PATHS=()

# Build archive for the platform
DEVICE_ARCHIVE_PATH="${OUTPUT_DIR}/${FRAMEWORK_NAME}-${DEVICE_PLATFORM}.xcarchive"
FRAMEWORK_PATHS+=("-framework" "${DEVICE_ARCHIVE_PATH}/Products/usr/local/lib/${FRAMEWORK_NAME}.framework")

echo "Building for ${DEVICE_PLATFORM}..."
xcodebuild \
    -scheme "${SCHEME_NAME}" \
    -configuration Release \
    -destination "generic/platform=${DEVICE_PLATFORM}" \
    -derivedDataPath ${DERIVED_DATA_DIR} \
    -archivePath "${DEVICE_ARCHIVE_PATH}" \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    SKIP_INSTALL=NO \
    archive

# Build archive for the simulator if a simulator platform is defined
if [ -n "${SIMULATOR_PLATFORM}" ]; then
    SIMULATOR_ARCHIVE_PATH="${OUTPUT_DIR}/${FRAMEWORK_NAME}-${SIMULATOR_PLATFORM}.xcarchive"
    FRAMEWORK_PATHS+=("-framework" "${SIMULATOR_ARCHIVE_PATH}/Products/usr/local/lib/${FRAMEWORK_NAME}.framework")

    echo "Building for ${SIMULATOR_PLATFORM}..."
    xcodebuild \
        -scheme "${SCHEME_NAME}" \
        -configuration Release \
        -destination "generic/platform=${SIMULATOR_PLATFORM}" \
        -derivedDataPath ${DERIVED_DATA_DIR} \
        -archivePath "${SIMULATOR_ARCHIVE_PATH}" \
        BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
        SKIP_INSTALL=NO \
        archive
fi

# Create the XCFramework
echo "Creating XCFramework..."
xcodebuild -create-xcframework \
    "${FRAMEWORK_PATHS[@]}" \
    -output "${OUTPUT_DIR}/${FRAMEWORK_NAME}-${PLATFORM_ARG}.xcframework"

echo "XCFramework created successfully at ${OUTPUT_DIR}/${FRAMEWORK_NAME}-${PLATFORM_ARG}.xcframework"
