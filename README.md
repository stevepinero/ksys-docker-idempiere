ksys-docker-idempiere
=======================

Base docker image to run iDempiere-KSYS inside Apache Karaf

Usage
-----

To create the image `longnan/ksys-docker-idempiere`, execute the following command on the ksys-docker-idempiere folder:

	docker build --rm --force-rm -t longnan/ksys-docker-idempiere:2.0.20140608 .

To run the image:

	docker run -d -t --link ksys-postgresql:idempiere-db --name="ksys-idempiere" -p 8181:8181 -p 8101:8101 longnan/ksys-docker-idempiere:2.0.20140608

To start the container:	

	docker start ksys-idempiere

	
