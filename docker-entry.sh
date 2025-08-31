#!/bin/sh 
set -ex

register_binfmt() {
  mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc 
  if test -f /proc/sys/fs/binfmt_misc/qemu-aarch64; then 
    echo "binfmt already registered" >&2
  else
    echo ":aarch64_sheng:M::\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xb7\x00:\xff\xff\xff\xff\xff\xff\xff\xfc\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:$(which qemu-aarch64-static):F" > /proc/sys/fs/binfmt_misc/register || echo "Failed to register binfmt" >&2
  fi
}

unregister_binfmt(){
  if test -f /proc/sys/fs/binfmt_misc/aarch64_sheng; then
    echo -1 > /proc/sys/fs/binfmt_misc/aarch64_sheng
  fi
}

# Register binfmt for other archs
uname -m | grep aarch64 || register_binfmt

env PATH=/root/.local/bin:/root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin bash ./build.sh

uname -m | grep aarch64 || unregister_binfmt
