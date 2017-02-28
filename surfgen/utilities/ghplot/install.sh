#!/bin/bash

# set environmental variables
source ../../bin/setsgenvars.sh

echo Compiling ghplot
echo $SGENFC ghplot.f90 -o ghplot.x $SGENFLAG $SGENLIB
$SGENFC ghplot.f90 -o ghplot.x $SGENFLAG $SGENLIB
echo Copying executable to surfgen directory
cp ghplot.x $SGENDIR
echo Done 
