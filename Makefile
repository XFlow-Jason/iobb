# --- Standard Makefile Variables ---
# Use CC from the environment, defaulting to the old compiler if not set.
CC ?= arm-linux-gnueabihf-gcc
AR ?= ar

# Use CFLAGS from the environment, defaulting to -W.
# Your Docker command will add --target and --sysroot to this.
CFLAGS ?= -W
ARFLAGS ?= rs

# Use PREFIX from the environment for the installation path.
PREFIX ?= /usr/local


# --- Project Configuration ---
LIB_PATH = ./BBBio_lib/
TARGET_LIB = libiobb.a
TARGET_HEADER = iobb.h

# List all the object files that make up the library.
OBJECTS = $(LIB_PATH)BBBiolib.o \
          $(LIB_PATH)BBBiolib_PWMSS.o \
          $(LIB_PATH)BBBiolib_McSPI.o \
          $(LIB_PATH)BBBiolib_ADCTSC.o \
          $(LIB_PATH)i2cfunc.o

# List all the public headers to be installed.
HEADERS = $(LIB_PATH)BBBiolib.h \
          $(LIB_PATH)BBBiolib_ADCTSC.h \
          $(LIB_PATH)BBBiolib_McSPI.h \
          $(LIB_PATH)BBBiolib_PWMSS.h \
          $(LIB_PATH)i2cfunc.h


# --- Build Rules ---
.PHONY: all install clean

# Default target: build the library.
all: $(TARGET_LIB)

# Rule to link the final static library from all the object files.
$(TARGET_LIB): $(OBJECTS)
	$(AR) $(ARFLAGS) $@ $^

# Generic rule to compile any .c file from the library path into an object file.
# This single rule replaces all the repetitive, separate .o rules from the old file.
$(LIB_PATH)%.o: $(LIB_PATH)%.c
	$(CC) $(CFLAGS) -c $< -o $@

# Rule to install the library and headers to the paths specified by PREFIX.
install: $(TARGET_LIB)
	install -d $(PREFIX)/lib
	install -d $(PREFIX)/include
	install -m 644 $(TARGET_LIB) $(PREFIX)/lib/
	install -m 644 $(HEADERS) $(PREFIX)/include/
	# Create the main iobb.h header as a copy of BBBiolib.h
	install -m 644 $(LIB_PATH)BBBiolib.h $(PREFIX)/include/$(TARGET_HEADER)


#---------------------------------------------------
# Demo
#---------------------------------------------------

# test-outputs: test-io/test-outputs.c libiobb.a
# 	arm-linux-gnueabihf-gcc -o test-outputs test-io/test-outputs.c -I. -L. -liobb

# pb-test-outputs: test-io/pb-test-outputs.c libiobb.a
# 	arm-linux-gnueabihf-gcc -o pb-test-outputs test-io/pb-test-outputs.c -I. -L. -liobb

# test-inputs: test-io/test-inputs.c libiobb.a
# 	arm-linux-gnueabihf-gcc -o test-inputs test-io/test-inputs.c -I. -L. -liobb

# pb-test-inputs: test-io/pb-test-inputs.c libiobb.a
# 	arm-linux-gnueabihf-gcc -o pb-test-inputs test-io/pb-test-inputs.c -I. -L. -liobb

# LED : ${DEMO_PATH}Demo_LED/LED.c libiobb.a
# 	arm-linux-gnueabihf-gcc -o LED ${DEMO_PATH}Demo_LED/LED.c -L ${LIB_PATH} -liobb

# lcd3-test: ${DEMO_PATH}Demo_I2C/lcd3-test.c libiobb.a
# 	arm-linux-gnueabihf-gcc -o lcd3-test ${DEMO_PATH}Demo_I2C/lcd3-test.c -I. -L ${LIB_PATH} -liobb

# ADT7301 : ${DEMO_PATH}Demo_ADT7301/ADT7301.c libiobb.a
# 	arm-linux-gnueabihf-gcc -o ADT7301 ${DEMO_PATH}Demo_ADT7301/ADT7301.c -L ${LIB_PATH} -liobb

# ADXL345 :  ${DEMO_PATH}Demo_ADXL345/ADXL345.c libiobb.a
# 	arm-linux-gnueabihf-gcc -o ADXL345 ${DEMO_PATH}Demo_ADXL345/ADXL345.c -L ${LIB_PATH} -liobb
# ADXL345_NET :  ${DEMO_PATH}Demo_ADXL345/ADXL345_net.c libiobb.a
# 	arm-linux-gnueabihf-gcc -o ADXL345 ${DEMO_PATH}Demo_ADXL345/ADXL345_net.c -L ${LIB_PATH} -liobb

# L3G4200D : ${DEMO_PATH}Demo_L3G4200D/L3G4200D.c libiobb.a
# 	arm-linux-gnueabihf-gcc -o L3G4200D ${DEMO_PATH}Demo_L3G4200D/L3G4200D.c -L ${LIB_PATH} -liobb

# SEVEN_SCAN : ${DEMO_PATH}Demo_SevenScan/SevenScan.c libiobb.a
# 	arm-linux-gnueabihf-gcc -o SevenScan ${DEMO_PATH}Demo_SevenScan/SevenScan.c  -L ${LIB_PATH} -liobb

# SMOTOR : ${DEMO_PATH}Demo_ServoMotor/ServoMotor.c libiobb.a
# 	arm-linux-gnueabihf-gcc -o SMOTOR ${DEMO_PATH}Demo_ServoMotor/ServoMotor.c -L ${LIB_PATH} -liobb

# LED_GPIO : ${DEMO_PATH}Demo_LED_GPIO/LED_GPIO.c libiobb.a
# 	arm-linux-gnueabihf-gcc -o LED_GPIO ${DEMO_PATH}Demo_LED_GPIO/LED_GPIO.c -L ${LIB_PATH} -liobb -pthread

# DEBOUNCING : ${DEMO_PATH}Demo_Debouncing/Debouncing.c libiobb.a
# 	arm-linux-gnueabihf-gcc -o Debouncing ${DEMO_PATH}Demo_Debouncing/Debouncing.c -L ${LIB_PATH} -liobb

# 4x4keypad : ${DEMO_PATH}Demo_4x4keypad/4x4keypad.c libiobb.a
# 	arm-linux-gnueabihf-gcc -o 4x4keypad ${DEMO_PATH}Demo_4x4keypad/4x4keypad.c -L ${LIB_PATH} -liobb

# PWM : ${DEMO_PATH}Demo_PWM/PWM.c libiobb.a
# 	arm-linux-gnueabihf-gcc -o PWM ${DEMO_PATH}Demo_PWM/PWM.c -L ${LIB_PATH} -liobb

# ADC : ${DEMO_PATH}Demo_ADC/ADC.c libiobb.a
# 	arm-linux-gnueabihf-gcc -o ADC ${DEMO_PATH}Demo_ADC/ADC.c -L ${LIB_PATH} -liobb -lm

# ADC_VOICE : ${DEMO_PATH}Demo_ADC/ADC_voice.c libiobb.a
# 	arm-linux-gnueabihf-gcc -o ADC_VOICE ${DEMO_PATH}Demo_ADC/ADC_voice.c -L ${LIB_PATH} -liobb -lm -pthread -O3



# #---------------------------------------------------
# # toolkit 
# #---------------------------------------------------

# GPIO_STATUS : ${TOOLKIT_PATH}Toolkit_GPIO_CLK_Status/GPIO_status.c libiobb.a
# 	arm-linux-gnueabihf-gcc -o GPIO_CLK_status ${TOOLKIT_PATH}Toolkit_GPIO_CLK_Status/GPIO_status.c  -L ${LIB_PATH} -liobb

# EP_STATUS : ${TOOLKIT_PATH}Toolkit_EP_Status/EP_status.c libiobb.a
# 	arm-linux-gnueabihf-gcc -o EP_status ${TOOLKIT_PATH}Toolkit_EP_Status/EP_status.c -L ${LIB_PATH} -liobb


# ADC_CALC : ${TOOLKIT_PATH}Toolkit_ADC_CALC/ADC_CALC.c
# 	arm-linux-gnueabihf-gcc -o ADC_CALC ${TOOLKIT_PATH}Toolkit_ADC_CALC/ADC_CALC.c


# #---------------------------------------------------
# # Lab
# #---------------------------------------------------

# RA : ${LAB_PATH}Lab_Robot_Arm/Robot_Arm.c libiobb.a
# 	arm-linux-gnueabihf-gcc -o RA  ${LAB_PATH}Lab_Robot_Arm/Robot_Arm.c -L ${LIB_PATH} -liobb -lm

# VD : ${LAB_PATH}Voice_Door/voice_door.cpp libiobb.a
# 	g++ -o VD ${LAB_PATH}Voice_Door/voice_door.cpp -L ${LIB_PATH} -liobb -lfftw3 -lm -pthread -O3


# Rule to clean up all generated files.
clean:
	rm -f $(OBJECTS) $(TARGET_LIB)
