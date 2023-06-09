DEVICE=$1
BASE="device/samsung"
UNI="${BASE}/a50-common"
DEV="${BASE}/${DEVICE}"

VENDOR=$(cat ${UNI}/vendor_name)
if [ ! $VENDOR ]; then
	VENDOR=aosp
fi
# Generate AndroidProducts.mk
echo "# Auto-Generated by ${DEV}/setup.sh" >${DEV}/AndroidProducts.mk
echo "PRODUCT_MAKEFILES += \$(LOCAL_DIR)/"$VENDOR"_${DEVICE}.mk" >>${DEV}/AndroidProducts.mk

# Generate <vendor>_${DEVICE}.mk
echo "# Auto-Generated by ${DEV}/setup.sh" >${DEV}/"$VENDOR"_${DEVICE}.mk
echo "\$(call inherit-product, ${DEV}/full_${DEVICE}.mk)" >>${DEV}/"$VENDOR"_${DEVICE}.mk
if test -f vendor/"$VENDOR"/config/common_full_phone.mk && echo "common_full_phone"; then
	echo "\$(call inherit-product, vendor/"$VENDOR"/config/common_full_phone.mk)" >>${DEV}/"$VENDOR"_${DEVICE}.mk
elif test -f vendor/"$VENDOR"/config/common.mk && echo "common"; then
	echo "\$(call inherit-product, vendor/"$VENDOR"/config/common.mk)" >>${DEV}/"$VENDOR"_${DEVICE}.mk
fi
echo "PRODUCT_NAME := "$VENDOR"_${DEVICE}" >>${DEV}/"$VENDOR"_${DEVICE}.mk
echo "" >>${DEV}/"$VENDOR"_${DEVICE}.mk
echo "# Additional Props" >>${DEV}/"$VENDOR"_${DEVICE}.mk
echo "TARGET_FACE_UNLOCK_SUPPORTED := true" >>${DEV}/"$VENDOR"_${DEVICE}.mk
echo "TARGET_BOOT_ANIMATION_RES := 1080" >>${DEV}/"$VENDOR"_${DEVICE}.mk
