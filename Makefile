.PHONY : main build-image build-container start test shell stop clean
main: build-image build-container

build-image:
	docker build -t twitch-test-types .

build-container:
	docker run -dt --name twitch-test-types -v .:/540/TwitchTestTypes twitch-test-types
	docker exec twitch-test-types composer install

start:
	docker start twitch-test-types

test: start
	docker exec twitch-test-types ./vendor/bin/phpunit tests/$(target)

shell: start
	docker exec -it twitch-test-types /bin/bash

stop:
	docker stop twitch-test-types

clean: stop
	docker rm twitch-test-types
	rm -rf vendor
