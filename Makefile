ARCHS = armv7 armv7s arm64

TARGET = iphone:clang:latest:5.0

THEOS_BUILD_DIR = Packages

FINALPACKAGE = 1

include theos/makefiles/common.mk

TWEAK_NAME = NoBatteryPercent
NoBatteryPercent_CFLAGS = -fobjc-arc
NoBatteryPercent_FILES = NoBatteryPercent.xm
NoBatteryPercent_FRAMEWORKS = Foundation

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
