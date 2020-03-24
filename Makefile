main: ver rt push

ver:
	docker run --rm -it -v `pwd`/.env:/src/.env $(REG)/ci/gulp:$(GULP) ver

rt:
	time docker-compose build $@

push pull:
	docker-compose $@ rt

run-rt:
	docker-compose run --rm rt

run-bash:
	docker-compose run --rm rt bash
