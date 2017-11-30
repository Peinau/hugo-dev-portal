run:
	docker build -t docu-site:0.0.1 .
	docker run --volume "$(shell pwd)/site:/usr/share/blog"  --rm -it -p 1313:1313 docu-site:0.0.1