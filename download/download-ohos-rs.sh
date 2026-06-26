#!/bin/bash

set -eu

if command -v rustup &> /dev/null; then
  echo "rustup is already installed"
else
  echo "Installing rustup..."
  wget -qO - https://sh.rustup.rs | sh
fi

rustup target add aarch64-unknown-linux-ohos
cargo install cargo-c --features=vendored-openssl
