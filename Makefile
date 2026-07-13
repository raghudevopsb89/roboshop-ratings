.PHONY: build run unit-test integration-test docker-build db-init clean

build:
	pip install -r requirements.txt

run:
	MYSQL_HOST=localhost python app.py

unit-test:
	pytest -m "not integration"

integration-test:
	pytest -m integration

docker-build:
	env
	docker build -t raghudevopsb89.azurecr.io/roboshop-ratings:${GITHUB_SHA} .

docker-push:
	docker push raghudevopsb89.azurecr.io/roboshop-ratings:${GITHUB_SHA}

db-init:
	mysql -h $${MYSQL_HOST:-localhost} -u root -pRoboShop@1 < db/app-user.sql
	mysql -h $${MYSQL_HOST:-localhost} -u root -pRoboShop@1 < db/schema.sql

clean:
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
