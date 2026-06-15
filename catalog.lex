# catalog.lex — the single source of truth for the Lex ecosystem.
#
# Every public surface (llms.txt, the GitHub org profile README, and the
# lexlang.org landing page) is GENERATED from this file by generate.lex. Edit
# ONLY this file when a package is added, renamed, or changes status; CI then
# regenerates the surfaces and fails if any committed output drifts from here,
# and a reality check fails if a public lex-* repo is missing or mis-described.
#
# It is a type-checked Lex value on purpose: the project's own catalog is held to
# the same standard as the code — illegal states (unknown layer/status) won't
# compile, and each package's summary lives in exactly one place. Summaries are
# taken from each repo's own README/lex.toml, never invented.

# Coarse layer the package sits in (ordered substrate -> verticals in generate.lex).
type Layer = Substrate | Library | Agents | Finance | Energy | Robotics

# How far along it is — assigned from EVIDENCE, not opinion (scripts/audit_status.sh):
#   Runnable = latest push CI green AND has an examples/ demo
#   Beta     = latest push CI green AND has tests (no demo yet)
#   Alpha    = code exists but CI is red or absent (unverified)
#   Idea     = essentially empty / a plan
# Fix a repo's CI and re-run the audit to promote it — labels are earned.
type Status = Runnable | Beta | Alpha | Idea

type Pkg = {
  name :: Str,
  layer :: Layer,
  status :: Status,
  public :: Bool,     # only public packages are rendered onto the public surfaces
  summary :: Str,     # from the repo's own README/lex.toml, never invented
  hero :: Str,        # one command a newcomer can run, or "" if none yet
}

fn canonical() -> Str { "https://lexlang.org" }

fn org() -> Str { "alpibrusl" }

fn packages() -> List[Pkg] {
  [
    # ── Substrate: the language, runtime, registry, tooling ───────────────────
    { name: "lex-lang", layer: Substrate, status: Runnable, public: true,
      summary: "Typed-effect language built for LLM authorship; effects are the contract, checked before run.",
      hero: "lex check program.lex" },
    { name: "lex-os", layer: Substrate, status: Runnable, public: true,
      summary: "Sealed, sandboxed execution box handed to an agent with a goal and a budget.",
      hero: "lex-os check --grant grant.json agent.lex" },
    { name: "lex-os-manifest", layer: Substrate, status: Beta, public: true,
      summary: "Manifest format as a Lex package: trust dimensions, grants, narrowing inheritance as types.",
      hero: "" },
    { name: "lex-cli", layer: Substrate, status: Runnable, public: true,
      summary: "CLI framework for Lex: arg parsing, ACLI output, config, authenticated HTTP client.",
      hero: "" },
    { name: "lex-spec", layer: Substrate, status: Runnable, public: true,
      summary: "Capability-precondition + spec DSL: Spec ADT, evaluator, property checks, SMT-LIB export.",
      hero: "" },
    { name: "lex-hub", layer: Substrate, status: Beta, public: false,
      summary: "SaaS gateway for Lex: JWT-authed multi-tenant HTTP server with per-tenant isolated stores.",
      hero: "" },
    { name: "lex-canon", layer: Substrate, status: Alpha, public: false,
      summary: "Tier-honest verifiable claim-record layer over the Lex toolchain (proof of concept).",
      hero: "" },

    # ── Libraries: horizontal building blocks ─────────────────────────────────
    { name: "lex-web", layer: Library, status: Runnable, public: true,
      summary: "HTTP + WebSocket framework: actor-model concurrency; one schema drives every artifact.",
      hero: "" },
    { name: "lex-schema", layer: Library, status: Runnable, public: true,
      summary: "Pydantic-style runtime validation, codegen, and schema utilities for Lex.",
      hero: "" },
    { name: "lex-orm", layer: Library, status: Runnable, public: true,
      summary: "Typed query builder, migration runner, and live std.sql driver built on lex-schema.",
      hero: "" },
    { name: "lex-money", layer: Library, status: Runnable, public: true,
      summary: "Exact decimal monetary arithmetic for the Lex language.",
      hero: "" },
    { name: "lex-log", layer: Library, status: Runnable, public: true,
      summary: "OpenTelemetry-compatible structured logging, tracing, and metrics for Lex.",
      hero: "" },
    { name: "lex-llm", layer: Library, status: Runnable, public: true,
      summary: "Pure-Lex LLM-agent runtime: provider abstraction, tool-call loop, structured outputs.",
      hero: "" },
    { name: "lex-mcp", layer: Library, status: Runnable, public: true,
      summary: "MCP stdio server bridging lex-agent Skills to MCP JSON-RPC.",
      hero: "" },
    { name: "lex-trail", layer: Library, status: Runnable, public: true,
      summary: "Content-addressed, append-only audit trail: attestation chains and task replay.",
      hero: "" },
    { name: "lex-jobs", layer: Library, status: Runnable, public: true,
      summary: "SQL-backed durable background job queue: enqueue, pull, dispatch, ack, retries.",
      hero: "" },
    { name: "lex-crypto", layer: Library, status: Beta, public: true,
      summary: "Crypto for Lex: JWT, OAuth2/PKCE, Argon2id, sealed cookies, webhook verify, TOTP.",
      hero: "" },

    # ── Agents & orchestration ────────────────────────────────────────────────
    { name: "lex-agent", layer: Agents, status: Runnable, public: true,
      summary: "Pure-Lex Google A2A protocol: AgentCard, JSON-RPC, Task lifecycle, SSE streaming.",
      hero: "" },
    { name: "lex-guard", layer: Agents, status: Beta, public: true,
      summary: "Agent spending guardrails: capability-gated budget tokens with an attestation trail.",
      hero: "" },
    { name: "lex-code", layer: Agents, status: Runnable, public: true,
      summary: "Lex-native coding assistant built entirely in the Lex ecosystem.",
      hero: "" },
    { name: "lex-loom", layer: Agents, status: Beta, public: true,
      summary: "Multi-agent sprint cycles built on lex-soft (design stage).",
      hero: "" },
    { name: "lex-soft", layer: Agents, status: Beta, public: false,
      summary: "LLM-agent platform: registry, relationship graph, resolver, runner.",
      hero: "" },
    { name: "lex-finetune", layer: Agents, status: Alpha, public: false,
      summary: "Fine-tune a code model to know Lex from training: checker-in-the-loop + MLX LoRA.",
      hero: "" },

    # ── Finance vertical ──────────────────────────────────────────────────────
    { name: "lex-finance", layer: Finance, status: Runnable, public: true,
      summary: "Agent-native finance software stack for the Lex language.",
      hero: "" },
    { name: "lex-risk", layer: Finance, status: Runnable, public: true,
      summary: "Portfolio Greeks, notional, and Reg-T margin aggregation.",
      hero: "" },
    { name: "lex-positions", layer: Finance, status: Beta, public: true,
      summary: "Position tracking with WAAC, realized PnL, and a SQL-backed store.",
      hero: "" },
    { name: "lex-trade", layer: Finance, status: Runnable, public: true,
      summary: "Pre-trade order validation for the Lex language.",
      hero: "" },
    { name: "lex-sor", layer: Finance, status: Beta, public: true,
      summary: "Smart order routing for the Lex finance stack.",
      hero: "" },
    { name: "lex-fix", layer: Finance, status: Runnable, public: true,
      summary: "FIX 4.4 protocol adapter for the Lex language.",
      hero: "" },
    { name: "lex-marketdata", layer: Finance, status: Beta, public: true,
      summary: "Market and reference data for the Lex finance stack.",
      hero: "" },
    { name: "lex-oms", layer: Finance, status: Runnable, public: true,
      summary: "HTTP Order Management System wiring the finance stack on lex-web.",
      hero: "" },
    { name: "lex-oms-agent", layer: Finance, status: Runnable, public: true,
      summary: "LLM-backed autonomous trading agents with compile-time effect isolation.",
      hero: "" },

    # ── Energy & EV vertical ──────────────────────────────────────────────────
    { name: "lex-ocpp", layer: Energy, status: Runnable, public: true,
      summary: "OCPP library for Lex: v1.6 and v2.0.1 framing and handler dispatch.",
      hero: "" },
    { name: "lex-ocpi", layer: Energy, status: Runnable, public: true,
      summary: "OCPI 2.2.1 library for Lex: CPO / eMSP / PTP role endpoints.",
      hero: "" },
    { name: "lex-csms", layer: Energy, status: Beta, public: false,
      summary: "OCPP Charging Station Management System (CSMS) server.",
      hero: "" },
    { name: "lex-charge", layer: Energy, status: Beta, public: false,
      summary: "Charge service: charge-point control with a REST API onto the CSMS.",
      hero: "" },
    { name: "lex-ems", layer: Energy, status: Beta, public: false,
      summary: "EMS: smart charging, load balancing, SetChargingProfile.",
      hero: "" },
    { name: "lex-emsp", layer: Energy, status: Beta, public: false,
      summary: "eMSP: RFID tokens, drivers, CDRs, OCPI 2.2.1 roaming.",
      hero: "" },
    { name: "lex-ev-api", layer: Energy, status: Beta, public: false,
      summary: "Multi-tenant EV-fleet API gateway: routing, auth, proxying.",
      hero: "" },
    { name: "lex-tms", layer: Energy, status: Beta, public: false,
      summary: "Transport management system for the EV-fleet vertical.",
      hero: "" },
    { name: "lex-ev-fleet", layer: Energy, status: Beta, public: false,
      summary: "EV-fleet demo: LLM-driven agents built on lex-soft.",
      hero: "" },

    # ── Robotics vertical ─────────────────────────────────────────────────────
    { name: "lex-robot", layer: Robotics, status: Runnable, public: true,
      summary: "Effect-typed, capability-bounded governance layer over LeRobot.",
      hero: "make demo" },
  ]
}
