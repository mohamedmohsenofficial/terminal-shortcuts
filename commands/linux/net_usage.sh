#!/bin/bash

echo "-------------------------"
echo "Internet Usage Summary:"
echo "-------------------------"
vnstat

echo ""
echo "-------------------------"
echo "Daily Usage:"
vnstat -d | head -n 12

echo ""
echo "-------------------------"
echo "Top Days (Traffic):"
vnstat -t | head -n 12
