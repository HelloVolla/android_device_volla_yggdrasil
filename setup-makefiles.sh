#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2022 Hallo Welt Systeme UG
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

# Required!
export DEVICE=yggdrasil
export DEVICE_HEADER="yggdrasil"
export DEVICE_COMMON=mt6763-common
export VENDOR=volla

export DEVICE_BRINGUP_YEAR=2020

"./../../${VENDOR}/${DEVICE_COMMON}/setup-makefiles.sh" "$@"
