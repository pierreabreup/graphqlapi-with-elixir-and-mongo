SHELL := /bin/bash # Use bash syntax

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir_name := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

run:
	docker-compose run --service-ports --rm app

destroy:
	docker-compose down
	docker volume rm ${current_dir_name}_elixir-mix
	docker volume rm ${current_dir_name}_mongodb-data
	docker rmi ${current_dir_name}_app
