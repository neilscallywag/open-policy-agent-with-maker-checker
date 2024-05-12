.PHONY: up down reload logs

up:
	docker-compose up -d

down:
	docker-compose down

reload:
	docker-compose down
	docker-compose up -d

logs:
	docker-compose logs -f


.PHONY: test
test:
	@echo "Running OPA tests..."
	@opa test ./policies -v || (echo "Tests failed, please check the output above for details." && false)
