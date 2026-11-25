# Changelog

## Table of Contents

- [0.1.0](#010)

---

## 0.1.0

2026-11-25. The runtime the freight agents share, split out of freight-agents with its history.

- Model layer: one interface, Anthropic and OpenAI adapters, a scripted model, record-and-replay cassettes.
- Tools and hooks: typed tools marked read, write or send; validation, state allowlists, taint guard, recipient policy, idempotency, approval gate, redaction, size caps and audit around every call; the agent loop with turn, call and dollar budgets.
- State engine: state machines over an append-only SQLite event store, timers that fire once, stores safe across a server's worker threads.
- Knowledge: sourced documents and BM25 retrieval with citations; each agent loads its own documents with `package_corpus`.
- Evaluation: golden cases, graders, release gates, dated reports; recording a real model under a cap checked before each case, resuming without paying twice, refusing an unpriced model, and naming a stale cassette.
- MCP bridge behind the same hooks; OpenTelemetry spans with GenAI attributes; a cost meter.
- Integrations: email, a TMS client, EDI X12 reading and writing, PDF text, resilient HTTP; Idempotency-Key handling for mock services.
- Repository checks as commands: `freight-purity`, `freight-links`, `freight-denylist`.
