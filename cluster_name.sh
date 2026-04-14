#!/bin/bash

set -euo pipefail

# Parse named parameters
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dc)   dc="$2";   shift 2 ;;
    --net)  net="$2";  shift 2 ;;
    --os)   os="$2";   shift 2 ;;
    --lbLnx)   lbLnx="$2";   shift 2 ;;
    --lbWin)   lbWin="$2";   shift 2 ;;
    *)
      echo "Error: Unknown parameter '$1'" >&2
      exit 1
      ;;
  esac
done

# Validate required parameters
if [[ -z "${dc:-}" ]]; then
  echo "Error: --dc parameter is required. Valid values: KAYL, WINDHOF" >&2
  exit 1
fi

if [[ -z "${net:-}" ]]; then
  echo "Error: --net parameter is required. Valid values: LAN, DMZ_Tier1, DMZ_Tier2" >&2
  exit 1
fi

if [[ -z "${os:-}" ]]; then
  echo "Error: --os parameter is required. Valid values: LINUX, WINDOWS" >&2
  exit 1
fi

if [[ -z "${lbLnx:-}" ]]; then
  echo "Error: --lbLnx parameter is required." >&2
  exit 1
fi

if [[ -z "${lbWin:-}" ]]; then
  echo "Error: --lbWin parameter is required." >&2
  exit 1
fi

# Validate dc parameter
case "$dc" in
  KAYL|WINDHOF) ;;
  *)
    echo "Error: Invalid value for --dc: '$dc'. Valid values: KAYL, WINDHOF" >&2
    exit 1
    ;;
esac

# Validate net parameter
case "$net" in
  LAN|DMZ_Tier1|DMZ_Tier2) ;;
  *)
    echo "Error: Invalid value for --net: '$net'. Valid values: LAN, DMZ_Tier1, DMZ_Tier2" >&2
    exit 1
    ;;
esac

# Validate os parameter
case "$os" in
  LINUX|WINDOWS) ;;
  *)
    echo "Error: Invalid value for --os: '$os'. Valid values: LINUX, WINDOWS" >&2
    exit 1
    ;;
esac

# Build CLUSTER_NAME
CLUSTER_NAME="NTX-"

case "$dc" in
  KAYL)
    CLUSTER_NAME="${CLUSTER_NAME}KA-"
    ;;
  WINDHOF)
    CLUSTER_NAME="${CLUSTER_NAME}WI-"
    ;;
esac

case "$net" in
  LAN)
    CLUSTER_NAME="${CLUSTER_NAME}LAN-"
    ;;
  DMZ_Tier1)
    CLUSTER_NAME="${CLUSTER_NAME}DMZ-T1-"
    ;;
  DMZ_Tier2)
    CLUSTER_NAME="${CLUSTER_NAME}DMZ-T2-"
    ;;
esac

if [[ "$net" == "LAN" ]]; then
  case "$os" in
    LINUX)
      CLUSTER_NAME="${CLUSTER_NAME}LNX-0${lbLnx}"
      ;;
    WINDOWS)
      CLUSTER_NAME="${CLUSTER_NAME}WIN-0${lbWin}"
      ;;
  esac
else
  CLUSTER_NAME="${CLUSTER_NAME}01"
fi

echo "CLUSTER_NAME: $CLUSTER_NAME"
