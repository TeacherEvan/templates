# spring-boot-api

A practical **Spring Boot 3** REST API starter (Java 21) with validation, Actuator health, and a MockMvc test.

## What's included

- `ApiApplication` entry point
- `HealthController` (`GET /api/health`)
- `GreetController` (`POST /api/greet`) demonstrating `@Valid` request bodies
- `application.yml` with env-overridable port
- JUnit 5 + MockMvc test

## What it is NOT

- Not wired to a database (add JPA + a migration tool when needed).
- Not secured (add Spring Security / OAuth2 for production).

## Prerequisites

- Java 21
- Maven 3.9+

## Run it

```bash
mvn spring-boot:run
curl http://localhost:8080/api/health
```

## Test

```bash
mvn test
```
