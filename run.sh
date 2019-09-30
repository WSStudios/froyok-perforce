#!/usr/bin/with-contenv bash
set -e

export NAME="${NAME:-p4depot}"

bash /usr/local/bin/setup-perforce.sh
bash /usr/local/bin/setup-git-fusion.sh

# python /opt/perforce/git-fusion/libexec/p4gf_super_init.py -p "$P4PORT" -u "$P4USER"
# /opt/perforce/git-fusion/libexec/p4gf_submit_trigger.py --install "$P4PORT" "$P4USER" "$P4PASSWD"


exec /usr/sbin/sshd -D -e
