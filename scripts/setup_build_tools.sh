#!/bin/sh

which -s xcodegen
if [[ $? != 0 ]] ; then
    # Install xcodegen
	echo "Installing xcodegen."
    brew install xcodegen
fi