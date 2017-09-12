all: build

build: namespace.yml proxy.yml proxy-service.yml crowi.yml crowi-service.yml mongo.yml mongo-service.yml redis.yml redis-service.yml elasticsearch.yml elasticsearch-service.yml plantuml.yml plantuml-service.yml
	kubectl create -f namespace.yml -f proxy.yml -f proxy-service.yml -f crowi.yml -f crowi-service.yml -f mongo.yml -f mongo-service.yml -f redis.yml -f redis-service.yml -f elasticsearch.yml -f elasticsearch-service.yml -f plantuml.yml -f plantuml-service.yml --save-config

destroy:
	kubectl delete namespace crowi
