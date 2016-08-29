# script I wrote to subvert time-restricted airport hotspots
#
# -d returns the adapters mac address to DEFAULT_MAC
# -r randomizes the adapter MAC but preserves the NIC manufacturer portion
DEFAULT_MAC="Y0:UR:MA:CC:HE:RE"
DEFAULT_MAN="Y0:UR:MA:"

while test $# -gt 0; do
        case "$1" in
                -r)
                  NEWMAC="$(openssl rand -hex 3 | sed 's/\(..\)/\1:/g; s/.$//')"
                  echo "[+] Randomizing en0 MAC to $DEFAULT_MAN${NEWMAC}"
                  sudo ifconfig en0 ether $DEFAULT_MAN$NEWMAC
                  exit 0
                  ;;
                -d)
                  echo "[+] Returning en0 to default MAC of $DEFAULT_MAC"
                  sudo ifconfig en0 ether $DEFAULT_MAC
                  exit 0
                  ;;
                -h|--help)
                  echo "usage: changemac [-r] [-d]"
                  echo "  -r      randomize MAC for interface en0"
                  echo "  -d      return MAC address for en0 to DEFAULT_MAC"
                  exit 0
                  ;;
                *)
                  echo "usage: changemac [-r] [-d]"
                  echo "  -r      randomize MAC for interface en0"
                  echo "  -d      return MAC address for en0 to DEFAULT_MAC"
                  exit 0
                  ;;
          esac
  done
