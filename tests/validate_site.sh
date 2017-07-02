#!/bin/bash

# validate_site.sh checks if the site.conf is valid json

GLUON_SITEDIR="." lua5.1 tests/site_config.lua
              
