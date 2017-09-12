crowi = crowi:1.6.2
crowi-es = crowi-es:5
registry = 10.0.3.1:5000/crowi
build = docker build
forcebuild = docker build --force-rm=true --no-cache=true
push = docker push

all: build

build: crowi/Dockerfile elasticsearch/Dockerfile
	$(build) -t $(registry)/$(crowi) ./crowi
	$(build) -t $(registry)/$(crowi-es) ./elasticsearch

push:
	$(push) $(registry)/$(crowi)
	$(push) $(registry)/$(crowi-es)
