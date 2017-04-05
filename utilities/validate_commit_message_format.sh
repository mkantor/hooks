#!/bin/sh

# Loosely validate the commit message format.

# Rules inspired by: 
# 
# - http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
# - http://git-scm.com/book/ch5-2.html#Commit-Guidelines
# 
# However, the common "first line under ~50 characters" rule is not enforced. 
# All lines must be under 72 characters.


unset CDPATH
set -o errexit

# Expect commit message from standard input.
COMMIT_MESSAGE=$(cat)

MAXIMUM_LINE_LENGTH=72

if [ -z "$COMMIT_MESSAGE" ]
then
	echo 1>&2 "$0: Commit message was blank."
	exit 66
fi

# Make sure lines aren't too long.
LONGEST_LINE_LENGTH=0
ORIGINAL_IFS=$IFS
IFS='
'
for LINE in $COMMIT_MESSAGE
do
	if [ ${#LINE} -gt $LONGEST_LINE_LENGTH ]
	then
		LONGEST_LINE_LENGTH=${#LINE}
	fi
done
IFS=$ORIGINAL_IFS
if [ $LONGEST_LINE_LENGTH -gt $MAXIMUM_LINE_LENGTH ]
then
	echo 1>&2 "$0: Longest line of commit message was $LONGEST_LINE_LENGTH characters, maximum length is $MAXIMUM_LINE_LENGTH."
	exit 65
fi

# If there is more than one line, the second line must be blank.
NUMBER_OF_LINES=$(echo "$COMMIT_MESSAGE" | wc -l)
if [ $NUMBER_OF_LINES -gt 1 ]
then
	SECOND_LINE=$(echo "$COMMIT_MESSAGE" | sed -n 2p)
	if [ -n "$SECOND_LINE" ]
	then
		echo 1>&2 "$0: Second line of commit message ('$SECOND_LINE') was not blank."
		exit 65
	fi
fi
