#!/usr/bin/env bash

# This script publishes the cf-usb-sidecar bundle
# Most arguments come from the task definition

set -o errexit

if [[ "${COMMIT_SOURCES}" != "true" ]]; then
  echo "+-----------------------------------------------+"
  echo "| Publishing sources is disabled for this build |"
  echo "+-----------------------------------------------+"
  exit 0;
fi

OSC_TARGET=OSCTEMP
OSC_BASE_PATH=Cloud:Platform:sources:sidecars
PACKAGE=cf-usb-sidecar

# Setup .oscrc
sed -i "s|<username>|$OBS_USERNAME|g" /root/.oscrc
sed -i "s|<password>|$OBS_PASSWORD|g" /root/.oscrc

mkdir -p "${OSC_TARGET}"
cd "${OSC_TARGET}"
osc checkout -M "${OSC_BASE_PATH}"
cd "${OSC_BASE_PATH}"
if [ ! -d "${PACKAGE}" ]; then
  osc mkpac "${PACKAGE}"
fi
cd "${PACKAGE}"
tar cfz "cf-usb-sidecar.tar.gz" -C "../../../src/" ./
osc addremove
osc commit -m "Add sources"