run: buildLocally
	source ./build.sh && run
runDocker: buildDocker
	source ./build.sh && runDocker
buildDocker: 
	source ./build.sh && buildDocker
buildLocally: 
	source ./build.sh && buildLocally
push: buildDocker
	source ./build.sh && push
createNamespace: 
	source ./build.sh && createNamespace
installArgo: createNamespace
	source ./build.sh && installArgo
deploy: createNamespace
	source ./build.sh && deploy