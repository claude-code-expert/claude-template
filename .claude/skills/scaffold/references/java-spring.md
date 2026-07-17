# Scaffold: Java / Spring Boot

Spring 서비스는 **Spring Initializr**로 시작한다. pom/gradle을 손으로 쓰지 않고, Boot 버전은 서버 기본값에 맡긴다.

## 버전 / 도구 (2026-07 · 확인 후 사용)

- **Spring Boot 4.1.x** (Spring Framework 7 기반, 2025-11 GA). Java 17 최소, **Java 25 first-class**, Java 26까지 호환.
- **불변 DTO는 `record`** — Lombok은 컴파일러 내부 API에 의존해 신규 Java 버전에서 깨질 수 있다(신규 프로젝트 금지). 가변·빌더가 꼭 필요할 때만 Lombok 검토.
- Boot 4는 JUnit 4 제거·Jackson 3 등 변경 있음 → 신규는 Boot 4로 시작.

## 스캐폴드

웹 UI(`start.spring.io`)가 표준. CLI로도 가능 — **bootVersion 생략 → 서버 최신 기본값**:

```bash
curl https://start.spring.io/starter.zip \
  -d type=gradle-project \
  -d language=java \
  -d javaVersion=21 \
  -d dependencies=web,actuator \
  -d packaging=jar \
  -o app.zip && unzip app.zip
```

`javaVersion`은 21(LTS 하한, 안전) 또는 런타임이 준비되면 25. `bootVersion`은 넣지 않아 서버가 현행(4.1.x)을 채우게 둔다.

## 디렉터리 (Gradle · Initializr 생성)

```
app/
├── build.gradle
├── settings.gradle
└── src/
    ├── main/
    │   ├── java/com/example/app/
    │   │   └── AppApplication.java
    │   └── resources/
    │       └── application.yml
    └── test/
        └── java/com/example/app/
```

패키지는 **flat부터**. `controller/`·`service/`·`repository/` 계층 분리나 package-by-feature는 클래스가 늘 때 도입.

## 코드 샘플

`AppApplication.java` + `record` DTO + 컨트롤러:

```java
package com.example.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
public class AppApplication {
    public static void main(String[] args) {
        SpringApplication.run(AppApplication.class, args);
    }
}

// 불변 DTO: Lombok 대신 record
record Greeting(String message) {}

@RestController
class GreetController {
    @GetMapping("/greet")
    Greeting greet(@RequestParam(defaultValue = "world") String name) {
        return new Greeting("hello, " + name);
    }
}
```

## 피할 것

- 신규에 **Spring Boot 3.x** → 4.x.
- 신규 DTO에 **Lombok `@Data`/`@Value`** → `record` (native, 컴파일러 위험 없음).
- pom/gradle 손으로 작성 → Initializr.
- `bootVersion` 하드코딩 → 서버 기본값.

## 출처

- Spring Initializr — https://start.spring.io
- Spring Boot 4.0 GA — https://spring.io/blog/2025/11/20/spring-boot-4-0-0-available-now/
- Java record vs Lombok — https://www.baeldung.com/java-record-vs-lombok
