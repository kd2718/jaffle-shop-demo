#! /bin/bash

set -e

dbt deps
dbt seed .
dbt run
