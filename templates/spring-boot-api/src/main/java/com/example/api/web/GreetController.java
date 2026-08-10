package com.example.api.web;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/greet")
public class GreetController {

    public record GreetRequest(@NotBlank String name) {}

    @PostMapping
    public Map<String, String> greet(@Valid @RequestBody GreetRequest req) {
        return Map.of("message", "Hello, " + req.name() + "!");
    }
}
