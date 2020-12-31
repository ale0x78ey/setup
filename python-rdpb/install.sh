#!/bin/bash
set -x

python3 -m pip install --user -U pip
python3 -m pip install --user rpdb

source common/install.sh
install_setup

install rlwrap telnet

# Examples:
#
# try
#     import rpdb; dbg = rpdb.Rpdb(port=4444); dbg.set_trace();
# except Exception:
#     pass
#
# rlwrap telnet localhost 4444
