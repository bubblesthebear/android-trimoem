#!/bin/bash

# This is a script I made to learn more about Bash scripting and because I forgot git commands.  It also is a good example though of how I feel I created a quick script ALONG WITH a quick debug process to figure out if it worked or not without actually making any changes since those weren't required when I was simply testing whether passing a variable to a function would work, not whether or not the command would work.  I also like the formatting of echo and the spacing of the if and else

function clone_git
{

	echo "Function:  Add new Git clone"
	echo
	git clone $1
	echo
	echo - - -
	echo
	# Debug #
#	echo Clone $1

}

function push_update
{

	echo "Function:  Commit+add+push"
	git add *
	echo
	echo - - -
	echo
	git commit -m "$1"
	echo
	echo - - -
	echo
	echo "Waiting 1 second before git push"
	echo
	sleep 1
	git push
	echo
	echo "Waiting 2 seconds for git status"
	sleep 2
	git status
	# Debug #
	#	echo Push $1

}

function pull_update
{

	echo "Function:  Pull update"
	git pull

}

function fastcommit
{

	echo "Function:  FastCommit"
	git add * # should be redundant but doesn't work otherwise
	git commit -a -m "fastcommit" # -a should be the "git add" shortcut?
	echo

}


# If there is a script argument #

argvar=$1
# DEBUG #
# echo arg:  $argvar
# DEBUG END #

# END #


# If no script argument then ask for user input #

if [ -z "$argvar" ]
then
	echo "FastCommit an update without pushing it (1), Commit + add + push an update (2), Pull an update (3), Get working tree status (4), or Clone a repository (5)"
	echo
	read userreply # "too many arguments" error if there are spaces in the user reply.  Erorr is at each "if" statement below, THEN it will do my error catch "Invalid"
else
	userreply=$argvar # otherwise "userreply" is script argument
fi

if [ $userreply == '5' ] # User input for Clone
then
	echo URL?
	read giturl
	[ -z "$giturl" ] && echo "Invalid" || clone_git $giturl

elif [ $userreply == '2' ] # User input for Commit + add + push
then
	echo Message?
	read gitmessage
	[ -z "$gitmessage" ] && push_update "update" || push_update "$gitmessage" #experimenting whether this is a one-line if else statement

elif [ $userreply == '4' ] # User input for Status
then
	git status

elif [ $userreply == '3' ] # User input for Pull
then
	pull_update

elif [ $userreply == '0' ] # User input for Exit
then
	echo "EXIT"
	exit

elif [ $userreply == '1' ] # User input for FastCommit
then
	echo
	fastcommit

else
	echo Invalid
fi

echo
read -p "Press ENTER to exit..."
echo
exit
