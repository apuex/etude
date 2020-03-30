# !/bin/bash

APP_DIR=$(cd $(dirname "$0"); pwd)

echo cleaning \"${APP_DIR}\"

cd ${APP_DIR}

# vs generated files
find ${APP_DIR} -name x64 -exec rm -rf {} \;
find ${APP_DIR} -name .vs -exec rm -rf {} \;
find ${APP_DIR} -name Release -exec rm -rf {} \;
find ${APP_DIR} -name Debug -exec rm -rf {} \;
# autotools generated
find ${APP_DIR} -name Makefile -exec rm -f {} \;
find ${APP_DIR} -name Makefile.in -exec rm -f {} \;

# haskell stack generated
rm -rf "${APP_DIR}/.stack-work"
rm -rf "${APP_DIR}/stack.yaml.lock"
# cmake generated vs project
rm -rf "${APP_DIR}/vs"

# autotools generated
rm -rf "${APP_DIR}/aclocal.m4"
rm -rf "${APP_DIR}/autom4te.cache"
rm -rf "${APP_DIR}/compile"
rm -rf "${APP_DIR}/config.guess"
rm -rf "${APP_DIR}/config.sub"
rm -rf "${APP_DIR}/configure"
rm -rf "${APP_DIR}/depcomp"
rm -rf "${APP_DIR}/dist"
rm -rf "${APP_DIR}/install-sh"
rm -rf "${APP_DIR}/ltmain.sh"
rm -rf "${APP_DIR}/m4"
rm -rf "${APP_DIR}/Makefile.in"
rm -rf "${APP_DIR}/missing"
rm -rf "${APP_DIR}/include/config.h.in"
