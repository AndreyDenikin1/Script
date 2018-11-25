#Initial Parameters
KERNEL_DIR=$PWD
IMAGE=$KERNEL_DIR/arch/arm64/boot/Image.gz-dtb
BUILD_START=$(date +"%s")

# Color Codes
Black='\e[0;30m' # Black
Red='\e[0;31m' # Red
Green='\e[0;32m' # Green
Yellow='\e[0;33m' # Yellow
Blue='\e[0;34m' # Blue
Purple='\e[0;35m' # Purple
Cyan='\e[0;36m' # Cyan
White='\e[0;37m' # White

# Tweakable options
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="AndreyDenikin"
export KBUILD_BUILD_HOST="DroidBox"
#export CROSS_COMPILE=/home/andrey/bin/utility/arm-cortex_a7_2/bin/arm-cortex_a7-linux-gnueabihf-
export CROSS_COMPILE=/home/andrey/AndreyDenikin/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-

# Compilation Scripts Are Below

compile_kernel ()
{
echo -e "$White***********************************************"
echo " Compiling ElectraBlue Kernel "
echo -e "***********************************************$nocol"
#make clean && make mrproper
RUN=`date +%H%M%S` && date && date » make.$RUN.log && /usr/bin/time -f "Total time: %E"
make mido_defconfig
make -j4
if ! [ -a $IMAGE ];
then
echo -e "$Red Kernel Compilation failed! Fix the errors! $nocol"
exit 1
fi
}
# Finalizing Script Below
case $1 in
clean)
make ARCH=arm64 -j4 clean mrproper
rm -rf include/linux/autoconf.h
;;
*)
compile_kernel
;;
esac
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$Green Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
