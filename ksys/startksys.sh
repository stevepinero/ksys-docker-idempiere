#!/bin/bash
# Starts up idempiere-ksys within the container.

# Stop on error
set -e

# Start idempiere-ksys
echo "Starting iDempiere KSYS..."
/opt/idempiere-ksys/bin/karaf


