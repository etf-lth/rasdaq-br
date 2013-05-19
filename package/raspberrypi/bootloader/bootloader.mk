BOOTLOADER_VERSION = 80d26df
BOOTLOADER_SITE = http://bsquask.com/downloads/firmware
BOOTLOADER_SOURCE = raspberrypi-bootloader-$(BOOTLOADER_VERSION).tar.gz
BOOTLOADER_INSTALL_TARGET = YES

define BOOTLOADER_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/boot
	cp $(@D)/start.elf $(TARGET_DIR)/boot/start.elf
	cp $(@D)/bootcode.bin $(TARGET_DIR)/boot/bootcode.bin
	cp $(@D)/fixup.dat $(TARGET_DIR)/boot/fixup.dat
	# Generate boot config files
	echo "dwc_otg.lpm_enable=0 console=ttyS0,115200 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline rootwait" > $(TARGET_DIR)/boot/cmdline.txt
	echo "avoid_safe_mode=1" > $(TARGET_DIR)/boot/config.txt
	echo "boot_delay=0" >> $(TARGET_DIR)/boot/config.txt
endef

$(eval $(generic-package))
