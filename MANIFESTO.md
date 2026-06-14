# Trust Without Comprehension

*A case for tools designed for AI, not adapted from humans*

*Alfonso Sastre — May 25, 2026*

---

## I. The Shape of a Tool

Every tool carries the assumptions of its maker. The hammer assumes a wrist. The keyboard assumes ten fingers and the ability to hold a thought long enough to spell it out. The spreadsheet assumes a mind that can hold a grid and navigate it cell by cell. These constraints are not bugs — they are the honest acknowledgment that tools are made by humans, for humans, shaped around human perception and human memory.

We are now building agents that can reason, write, plan, and act. And almost without exception, we are handing them human tools.

This is the central error of the current moment. Not a mistake in any single product or paper — a structural mistake in how we are framing the problem. We are asking agents to be very fast humans, when they could be something else entirely.

---

## II. On the Shoulders of Giants

Isaac Newton, writing to Robert Hooke in 1675, said: *"If I have seen further, it is by standing on the shoulders of giants."* The statement is often read as humility. It is also a statement about how knowledge compounds — each generation inherits the accumulated structure of the last and adds to it, rather than rebuilding from nothing.

The tools we are handing to agents are those giants. Python, Git, SQL, Jira, Figma — decades of careful thought about how to make computation and coordination tractable for human beings. They deserve respect. They are extraordinary achievements.

But inheriting a tool is not the same as being its right user. Newton inherited Galileo's observations and Kepler's laws. He did not inherit Galileo's telescope — he built a better one suited to what he was trying to see.

The question is not whether human tools are good. The question is: *what tool would you build if the user had no hands, no embodied attention span, no need for syntax sugar, and could hold a thousand constraints simultaneously within a single task without forgetting any of them?*

---

## III. The Mismatch

Consider what we ask of agents in the domain of software.

We ask them to write in languages with decades of syntax accumulated for human readability — indentation, named keywords, implicit operator precedence, liberal whitespace conventions. We ask them to manage version control through line-based diffs, where the unit of identity is a line of text rather than a named, typed, semantically stable unit of meaning. We ask them to navigate codebases of millions of lines, most of which are not the answer to any question the agent needs to ask. A semantic diff that says *"the type of `fn execute` changed from `[io] → Result[A, B]` to `[io, net] → Result[A, B]`"* tells an agent something. A diff that says *"line 47 changed"* tells a human something. We give them the second.

We ask them to read the entire codebase to build a mental model that they will discard at the end of the conversation, and rebuild from scratch the next call. Humans build mental models because we have to — we cannot hold the structure of a million-line system in working memory all at once, and the model amortizes the cost of comprehension across sessions. An agent has no working memory across sessions. Every conversation is the first. The right interface for an agent is not a codebase to read but a contract to satisfy.

We ask them, above all, to trust themselves through comprehension. Read the code. Understand the spec. Interpret the brief. But comprehension is a *human strategy* for building trust in the presence of ambiguity. It is not the only strategy. And for an agent — fast, tireless, but without continuous memory and prone to confident hallucination — it is not even the best one.

---

## IV. Trust Without Comprehension

**The thesis of this essay is that comprehension is not the only basis for trust, and that agent-native tools should be designed around a different one: verification.**

By *comprehension* I mean specifically the requirement that a human read and mentally simulate a system in order to vouch for it. Conceptual understanding of what the system does and why remains essential; what changes is whether that line-by-line interpretive validation is the substrate on which mechanical trust is built.

The right question is not *"how do we make Python better for agents?"* It is: if you were designing a programming language for an agent — not for a human to write, not for a human to read, but for an agent to generate and verify — what would you keep, and what would you discard?

You would keep types, because types are machine-verifiable constraints. You would keep algebraic data structures, because they make illegal states unrepresentable. You would keep effects, not as a documentation convention but as a formal declaration: this function may touch the network; this one may not. An agent that generates a function with a `[net]` effect row does not need to read the function body to know it touches the network. The type system tells it. The type system tells the caller. **Trust without comprehension.**

You would discard line-based version control, because lines are a human serialization format. The meaningful unit of a program is not a line — it is a function, a type, a module. Content-addressed AST nodes, stable identities across reformats, semantic versioning of functions not files — these are the primitives of version control designed for an agent.

You would discard large codebases as the unit of specification. The right interface for an agent is a small formal specification — a type signature, a set of examples, a set of properties — from which it can generate a correct implementation. Not a reference implementation to imitate, but a contract to satisfy.

And you would add **attestation**. Not review — attestation. An agent can generate code; a type checker can verify it; a test harness can run it; a sandbox can execute it with constrained effects; an append-only log can record exactly what happened, signed, content-addressed, tamper-evident. This chain is not understood — it is verified, at every link.

The substrate is not human-hostile. It supports projections — readable source views, narrative summaries, line-style diffs — derived from the same canonical form. What changes is which representation is load-bearing for trust.

---

## V. The Obvious Objection

The reflexive response to "trust without comprehension" is: *but someone still has to understand the system when it breaks.* When a regulator asks why an automated decision was made, when an engineer is paged at 3am, when a customer demands accountability — "the type checker said it was fine" is not a sufficient answer.

This is the strongest objection to the entire framing, and it deserves a direct response.

It is correct that humans bear residual responsibility, and that responsibility cannot be discharged by machinery alone. But notice what the objection actually asks for. It does not ask for the human to *re-derive* the system's behavior from first principles. It asks for the human to be able to *audit* the system after the fact: what was the input, what was the output, what constraints were checked, what effects were declared, what was logged.

Comprehension-based trust requires the human to hold the entire system in their head, in advance, in order to vouch for it. Verification-based trust requires the human to hold the system's *constraints* in their head — the spec, the effect set, the policy — and rely on tooling to enforce them. The audit surface is smaller. The review is sharper. The human is engaged where their judgment matters: at the spec, the policy, the trace — not at every line of every function body.

This is not the abolition of human oversight. It is the relocation of human oversight to the layer where it actually adds value, and the delegation of the rest to mechanisms that scale.

Verification scales cleanly for formal properties — types, effects, capabilities, invariants. It scales partially for testable behaviors, where well-chosen properties and examples can stand in for full specification. It scales poorly for aesthetic or intentional properties, where human judgment remains the only available oracle. The argument here is not that verification replaces judgment everywhere — only that it should replace comprehension wherever it can, so that judgment is reserved for the questions only humans can answer.

The current paradigm asks humans to comprehend everything and trust nothing. The agent-native paradigm asks humans to specify what matters and verify that it holds. The first is exhausting and increasingly impossible at the scale agents are starting to operate. The second is how every other mature engineering discipline already works — civil engineers do not personally verify each rivet; they specify the load and rely on the certification chain.

---

## VI. A Worked Example

The argument above is conceptual. Here is a concrete artifact.

I built `lex-code`, an AI coding assistant written entirely in Lex — a programming language designed under the discipline of this essay. The system prompts for each agent mode (build, spec, test, review) are about five lines of Lex each. The agent that generated the implementation worked from a compact language reference and the role description — no existing Lex codebase to imitate, no idiomatic examples beyond what the reference itself contained.

The orchestrator manages parallel multi-agent execution with effect-typed concurrency. One signature reads:

```
fn run_parallel(...) -> [env, concurrent, net, llm, io, proc, sql, fs_write, time] MultiResult
```

The agent figured that signature out from the spec, not from training data. It composed the effect rows correctly across parallel sub-agents. It threaded `Result` and `Option` through every error path. It distinguished construction-as-data (the agent definition) from execution-as-effect (the agent invocation), without being told to.

This is what *"designed for an agent to generate"* looks like in practice: the substrate carries the constraints; the model fills the bodies; the type system verifies the result. The model is not trusted because it was understood. It is trusted because what it produced was verified — by the type checker, by the spec checker, by the capability gate, by the trace. **Trust without comprehension, end to end.**

The artifact is not the point. The point is that the artifact exists, was produced under the discipline the essay describes, and behaves the way the essay predicts. The substrate did the work.

---

## VII. Beyond Code

The argument generalizes beyond programming languages, though I will not develop that case fully here. Briefly:

Every domain of human knowledge work has been organized around human cognitive constraints. The sprint is two weeks because human attention spans cannot sustain longer cycles without a visible checkpoint. The marketing brief is a document because humans need narrative to coordinate around ambiguity. The product roadmap is a slide deck because humans need visual hierarchy to establish priority. None of these constraints apply to agents.

The principle has the same shape in every domain: replace **comprehension** with **verification**, replace **human-readable artifacts** with **machine-checkable specifications**, replace **coordination through meeting** with **coordination through protocol**. In code, that means types, attestation, and content-addressed identity. In contract review, it would mean formal representations of obligations that an agent can check rather than legal prose a partner has to read. In compliance, it would mean policy expressed as executable constraints rather than PDFs interpreted by audit teams. In experiment design, it would mean preregistered protocols an agent can validate against rather than methods sections humans have to trust.

What stays constant across all of these is what does *not* change: humans still set the goals, humans still bear the responsibility, humans still decide what is worth verifying. The principle does not displace human judgment. It relocates the surface on which judgment is exercised — from comprehending the system to specifying what the system must do.

There is a deeper wager underneath this one: that more of human coordination can be expressed as constraints, protocols, and machine-checkable specifications than current practice assumes. That is the controversial claim, and the case for it is for another essay.

The point of this one is more modest: that the principle is sound, that the worked example exists, and that the move is the same wherever an agent meets a substrate built for someone else.

---

## VIII. The Division of Labor

None of this is an argument against humans. It is an argument for a cleaner separation of concerns.

**Humans set goals.** Humans decide what is worth building and why. Humans bear responsibility for consequences. These are not tasks to automate — they are tasks that require the particular kind of moral weight that only a person can carry.

**Agents execute.** Agents generate, verify, compose, test, deploy, monitor. These are tasks where human cognitive constraints — working memory, attention span, the need for readable syntax, the tolerance for line-based diffs — are friction, not features.

The transition requires new primitives. Languages whose specifications fit in a small formal grammar, not a thousand-page reference manual. Version control that operates on semantic units, not text lines. Specification formats that are machine-checkable, not human-interpreted. Attestation systems that produce trust without requiring comprehension at every step. Orchestration protocols that agents can reason about natively, not by parsing human-facing APIs.

Some of these exist in early form. The field of agent-native tooling is roughly where operating systems were in 1970: the ideas are nascent, the implementations are rough, the community is small. The opportunity is proportionate.

---

## IX. The Wager

The current moment is a wager.

One bet is that the right strategy is to make existing human tools incrementally better for agents — better context windows, better retrieval, better prompt engineering, better fine-tuning on existing codebases. This bet says the shape of the tool is fine; the agent just needs to get better at using it.

The other bet is that **the shape of the tool matters**. That there are capabilities — in code generation, in coordinated action across complex systems — that are not reachable by an agent using a hammer, however capable the agent becomes. That the right move is not to train agents to read Git history better, but to give them version control that was never designed around human readability in the first place.

The second bet is harder. It requires building new infrastructure rather than instrumenting existing infrastructure. It requires convincing communities built around human tools that the tools themselves, not their users, are the variable to change. It requires accepting a period where the new tools are immature — a valley between *"human tools, used by AI"* and *"agent-native tools, mature enough to rely on."*

But the second bet is also the one consistent with the actual nature of the shift. Agents are not faster humans. They have different strengths, different failure modes, different requirements for trust and verification. Giving them tools designed for human cognition is not a neutral choice — it is a choice to leave most of their potential unrealized, and to ask humans to comprehend at a scale that comprehension can no longer reach.

We are standing on the shoulders of giants. Now we build the next layer — not against what the giants built, but for a different writer, a different reader, a different basis for trust.

*Comprehension was a strategy. It is not the only one.*
