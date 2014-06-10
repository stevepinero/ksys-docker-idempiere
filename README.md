ksys-docker-idempiere
=======================

Base docker image to run iDempiere-KSYS inside Apache Karaf

Usage
-----

To create the image `longnan/ksys-docker-idempiere`, execute the following command on the ksys-docker-idempiere folder:

	docker build --rm --force-rm -t longnan/ksys-docker-idempiere:2.0.20140608 .

To run the image:

	docker run -d --link ksys-postgresql:idempiere-db --name="ksys-idempiere" -p 8181:8181 longnan/ksys-docker-idempiere:2.0.20140608
	docker run -d --link ksys-postgresql:idempiere-db --name="ksys-idempiere" -p 8181:8181 longnan/ksys-docker-idempiere:2.0.20140608 /sbin/my_init -- /opt/idempiere-ksys/bin/karaf

To start the container:	

	docker start ksys-idempiere

	
