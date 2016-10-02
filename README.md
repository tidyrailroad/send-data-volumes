
Sends data volumes to a remote destination.


# Introduction
Using the magic of docker outside of docker (dood) - see http://container-solutions.com/running-docker-in-jenkins-in-docker/ -
the container can run docker commands.

It uses this power to list all the docker data volumes and to mount them in another container which rsyncs them to a specified destination.


## Warning
For this to work, it is necessary to use the `--privileged` switch.
You should carefully review and trust this image before running it with the `privileged` switch because running it with the `privileged` switch gives it power equivalent to root.
**If you run a malevolent image with the `--privileged` switch, your system will have been rooted.**
(See http://obrown.io/2016/02/15/privileged-containers.html.)

# Recommend Usage

1) Create a volume with ssh configuration and keys.  I named mine "ssh".  Specify this in the environment variable DOT_SSH.

2) Decide where to send the files.  Specify this using the environment variables TARGET and DESTINATION.  The files will go to ${TARGET}:${DESTINATION}.

3) You must use the `--privileged` switch.  It will not work without it.

`docker run --interactive --tty --rm --env DOT_SSH=ssh --env TARGET=backupserver --env DESTINATION=volumes --privileged --volume /var/run/docker.sock:/var/run/docker.sock:ro emorymerryman/send-data-volumes:1.0.0`

Running this command, all your docker data volumes will be rsynced to the specified destination.