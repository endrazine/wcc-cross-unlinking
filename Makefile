all::
	docker build . -t wcc-cross-unlinking:latest --no-cache

run::
	docker run --user 0 -it wcc-cross-unlinking:latest bash

test::
	docker run --user 0 -it wcc-cross-unlinking:latest bash -c "make test"

filetypes::
	docker run --user 0 -it wcc-cross-unlinking:latest bash -c "make filetypes"
