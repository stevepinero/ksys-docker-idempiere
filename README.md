ksys-docker-idempiere
=======================

Base docker image to run iDempiere-KSYS inside Apache Karaf

Usage
-----

To create the image `longnan/ksys-docker-idempiere`, execute the following command on the ksys-docker-idempiere folder:

	docker build --rm --force-rm -t longnan/ksys-docker-idempiere:2.1.20141101 .

To run the image:
	
	docker run -d --name="ksys-postgresql" -p 5432:5432 -e PASS="postgres" longnan/ksys-docker-postgresql:2.1.20141101
	docker run -d -t --link ksys-postgresql:idempiere-db --name="ksys-idempiere" -p 8181:8181 -p 8101:8101 longnan/ksys-docker-idempiere:2.1.20141101

To start the container:	

	docker start ksys-postgresql
	docker start ksys-idempiere

	
