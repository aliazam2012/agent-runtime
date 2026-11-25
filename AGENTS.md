# Agent Instructions

## Table of Contents

- [Commands](#commands)
- [Rules](#rules)
- [Where Things Go](#where-things-go)

---

## Commands

- `make setup`: install every package into one environment with uv.
- `make check`: ruff, mypy strict and pytest. Run it before every commit.
- `make purity`: the clean-room scan and the Markdown link check.

## Rules

- Test first: write the failing test, watch it fail, then write the code.
- Never call a paid model API from a test. Use `ScriptedModel` or a cassette.
- Never move a case's state from a tool or a prompt; tools propose, `CaseEngine.fire` decides.
- Any tool that sends outside is `Risk.SEND` and is declared in the taint guard's controls.
- Made-up data only, on `example.com`, `example.net` or `example.org`.
- A change other repos depend on ships as a tagged release; the agent repos bump the tag in their own pull requests.

## Where Things Go

Everything here is shared by the agent repos: the model layer, tools and hooks, state machines, retrieval, evaluation, recording, MCP, telemetry, integrations and the repository checks. Anything specific to one agent (prompts, tools, its state machine, its documents) belongs in that agent's repo.
