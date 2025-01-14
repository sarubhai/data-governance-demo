#!/bin/sh
set -x

# Execute dbt commands in sequence
dbt deps && \
dbt build && \
dbt docs generate --no-compile
