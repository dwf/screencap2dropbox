#!/bin/bash

# screencap2dropbox.sh -- Takes a screenshot with Mac OS X's 
# 'screencapture' utility, places the output in a publicly accessible
# Dropbox folder ( http://www.dropbox.com/ for more information )
# and then copies the URL to the clipboard. 
#
# By David Warde-Farley, March 18, 2010. Inspired by an earlier Automator
# version by Andrew Louis.

# where to store screen captures.
DIR="$HOME/Dropbox/Public/screencaps"

# Retrieve your Dropbox ID from a flat file in the home directory
DROPBOX_UID="`cat $HOME/.dropbox_uid 2>/dev/null`"

if [ -z "$DROPBOX_UID" ]; then
    echo " "
    echo "Please put the numeric component of your Dropbox URLs in the file"
    echo "$HOME/.dropbox_uid so that we can produce correct URLs on the "
    echo "pasteboard. This can be accomplished by the terminal command:"
    echo " "
    echo "   echo NUMBER >~/.dropbox_uid"
    echo " "
    echo "where NUMBER is replaced by your Dropbox UID, i.e. 123456."
    echo "to retrieve this, open a file in your Public subdirectory using"
    echo "the Dropbox web interface and note the number that appears after"
    echo "/u/ in the URL."
    echo " "
    echo "-------"
fi
echo "Select region for the screenshot."
FNAME=cap_`date "+%m%d%Y_%H%M%S.png"`
mkdir -p "$DIR"
screencapture -i "$DIR/$FNAME"
if [ -e "$DIR/$FNAME" ]; then
    echo "http://dl.dropbox.com/u/${DROPBOX_UID}/screencaps/$FNAME" | pbcopy
    echo "$FNAME captured; URL is on the clipboard."
else
    echo "No screenshot taken."
fi