#!/bin/bash

DOCKER_CLI=`(which docker)`

case "$1" in
    "bash")
        $DOCKER_CLI exec -it $LAST_CONTAINER_ID bash
        return
        ;;
    "set")
        if [ "$2" -ge 0 -a "$2" -le 9 ]; then
            export LAST_CONTAINER_ID=`docker ps -q | sed -n $(($2+1))p`
        else
            export LAST_CONTAINER_ID="$2"
        fi

        echo $LAST_CONTAINER_ID
        return
        ;;
    "unset")
        export LAST_CONTAINER_ID=""
        return
        ;;
    "logs")
        if [ -z "$2" ]; then
            $DOCKER_CLI logs $LAST_CONTAINER_ID
            return
        fi
        ;;
    "run")
        export LAST_CONTAINER_ID=`$DOCKER_CLI "$@"`
        echo $LAST_CONTAINER_ID
        return
        ;;
    "kill")
        if [ -z "$2" ]; then
            $DOCKER_CLI kill $LAST_CONTAINER_ID
            return
        fi
        ;;
    "killall")
        $DOCKER_CLI kill `($DOCKER_CLI ps -q)`
        return
        ;;
    "rmall")
        $DOCKER_CLI rm `($DOCKER_CLI ps -q -a)`
        return
        ;;
    "current")
        if [ -z $LAST_CONTAINER_ID ]; then
            echo "No current container. use 'docker set <num>' or 'docker run ...' to set"
        else
            echo $LAST_CONTAINER_ID
        fi
        return
        ;;
    "help" | "")
        echo "dockerim: docker IMproved"
        echo
        echo "Usage:"
        echo "   docker set <ps index | container id> / docker run ..."
        echo "       Sets current container. ex: 'docker set 0' will set the current container to the first one on PS"
        echo
        echo "   docker unset"
        echo "       Clears current container"
        echo
        echo "   docker logs/kill"
        echo "       If run without a container ID, will use the current container"
        echo
        echo "   docker killall/rmall"
        echo "       Will kill/remove all containers"
        echo
        echo "   docker current"
        echo "       Will print the current container id"
        echo
        echo "Otherwise, this command will pass the command as is to docker CLI"
        echo
        echo
        ;;
esac

# Pass command to docker CLI if no special handling require
$DOCKER_CLI "$@"

