# Coding Standards

## Naming

Functions

snake_case()

Variables

UPPER_CASE for constants

lower_case for locals

---

## Formatting

- Four spaces for indentation
- One blank line between functions
- Quote variables
- Prefer printf over echo
- Always check exit codes

---

## Structure

Each module should expose public functions only.

Private helpers should remain internal.

Avoid duplicated parsing logic.

---

## Error Handling

Every module returns meaningful exit codes.

Never silently ignore failures.

---

## Logging

Never print debug information directly.

Use logger.sh instead.