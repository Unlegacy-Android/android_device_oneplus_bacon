#!/system/bin/sh
# Copyright (c) 2009-2016, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

# Setup ro.alarm_boot value to true when it is RTC triggered boot up
# For existing PMIC chips, the following mapping applies
# for the value of boot_reason:
#
# 0 -> unknown
# 1 -> hard reset
# 2 -> sudden momentary power loss (SMPL)
# 3 -> real time clock (RTC)
# 4 -> DC charger inserted
# 5 -> USB charger insertd
# 6 -> PON1 pin toggled (for secondary PMICs)
# 7 -> CBLPWR_N pin toggled (for external power supply)
# 8 -> KPDPWR_N pin toggled (power key pressed)
boot_reason=`cat /proc/sys/kernel/boot_reason`
if [ "$boot_reason" = "3" ]; then
    setprop ro.alarm_boot true &
    setprop debug.sf.nobootanimation 1 &
else
    setprop ro.alarm_boot false &
fi

oppo_rf_version=`cat /proc/cmdline | tr ' ' '\n' | grep rf_version | cut -d'=' -f2`
if [ ! -z "$oppo_rf_version" ]; then
    setprop ro.oppo.rf_version $oppo_rf_version &
fi

oppo_hw_version=`cat /proc/cmdline | tr ' ' '\n' | grep hw_version | cut -d'=' -f2`
if [ ! -z "$oppo_hw_version" ]; then
    setprop  ro.oppo.pcb_version $oppo_hw_version &
fi
