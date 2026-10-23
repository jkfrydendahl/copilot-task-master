# Review Models Configuration

Use this guidance when explicitly selecting independent reviewers. Delivery and
review policy belong to the active user/project instructions, not this file.

## Model availability

Choose from the models actually available in the selected client/account, using
its current model picker and review help. Do not assume a fixed model ID or a
historical command alias still works. The `review` entry in `task-profiles.json`
selects one ordinary-review profile; it is not a multi-model reviewer roster.

## Choosing Models

When additional coverage is warranted, pick **2-3 available models from different
providers**. Different architectures can find different issues; additional passes
also consume credits. Use benchmarks to inform selection, not to claim that an
unavailable model can be invoked:

**General coding benchmarks:**
- [SWE-bench](https://www.swebench.com/) — Real-world software engineering tasks
- [Aider LLM Leaderboard](https://aider.chat/docs/leaderboards/) — Code editing performance
- [LiveBench](https://livebench.ai/) — Continuously updated reasoning benchmarks
- [Chatbot Arena](https://lmarena.ai/) — Community-driven model comparisons

**Domain-specific benchmarks:**
- For specialized domains (e.g., Business Central/AL, embedded systems, specific frameworks), look for domain-specific benchmarks that test models against real tasks in your stack
- Example: [AL Code Benchmark](https://ai.sshadows.dk/) for Microsoft Dynamics 365 Business Central

**Selection principles:**
1. **Diversity over raw ranking** — Three models from different providers catch more than three from the same provider
2. **Benchmark relevance** — A model ranked #1 on general reasoning may underperform on your specific stack
3. **Cost vs. value** — Premium models for critical reviews, faster models for routine checks
4. **Re-evaluate periodically** — Model rankings shift frequently; check benchmarks when updating
