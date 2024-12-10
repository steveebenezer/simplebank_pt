postgres:
	docker run --name postgres16 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -p 5433:5432 -d postgres:16-alpine

createdb:
	docker exec -t postgres16 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -t postgres16 dropdb simple_bank

migrateup:
	dbmate -u="postgresql://root:secret@localhost:5433/simple_bank?sslmode=disable" -d="./db/migrations" up

migratedown:
	dbmate -u="postgresql://root:secret@localhost:5433/simple_bank?sslmode=disable" -d="./db/migrations" down

dbconnect:
	docker exec -it postgres16 psql -U root

.PHONY: postgres createdb dropdb migrateup migratedown dbconnect
