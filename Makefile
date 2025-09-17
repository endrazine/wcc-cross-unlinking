all::
	docker build . -t wcc-cross-format:latest --no-cache

run::
	docker run --user 0 -it wcc-cross-format:latest bash

test::
	docker run --user 0 -it wcc-cross-format:latest bash -c "make test"

filetypes::
	docker run --user 0 -it wcc-cross-format:latest bash -c "make filetypes"
