#!/usr/bin/env python3

from jinja2 import Template
import sys

UBUNTU_VERSION = sys.argv[1]
BOOST_VERSION = sys.argv[2]

print("UBUNTU_VERSION", UBUNTU_VERSION)
print("BOOST_VERSION", BOOST_VERSION)

BOOST_SUBSTR=BOOST_VERSION.replace(".","_")
print("BOOST_SUBSTR", BOOST_SUBSTR)
BOOST_SRC=f"/opt/src/boost_{BOOST_SUBSTR}"
print("BOOST_SRC", BOOST_SRC)
BOOST_TAR_FILE=f"boost_{BOOST_SUBSTR}.tar.gz"
print("BOOST_TAR_FILE", BOOST_TAR_FILE)

python3_vers = {
    "18.04": {"python3_ver": "3.6", "python3_path": "3.6m"},
    "20.04": {"python3_ver": "3.8", "python3_path": "3.8"},
    "22.04": {"python3_ver": "3.10", "python3_path": "3.10"},
}

build_args = dict(BOOST_TAR_FILE=BOOST_TAR_FILE,
                  BOOST_SRC=BOOST_SRC,
                  PYTHON3_VER=python3_vers[UBUNTU_VERSION]["python3_ver"])

open("Dockerfile", "w").write(
    Template(open("./template/Dockerfile.template").read()).render(**build_args))


open("site-config.jam", "w").write(Template(open("./template/site-config.jam.template").read()
                                            ).render(**python3_vers[UBUNTU_VERSION]))
