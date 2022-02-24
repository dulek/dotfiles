#!/bin/bash

CODEDIR=~/Code

function cdcode {
    results=`find $CODEDIR -maxdepth 2 -type d -name "$1"`
    echo $results
}

_cdcode () {
    proj=${words[-1]}
    projs=(`find $CODEDIR -maxdepth 2 -type d -name "$proj*" -printf "%f\n"`)
    _describe 'command' projs
}

compdef _cdcode cdcode
