# Monthly task profile review (2026-07-03)

Reference: https://docs.github.com/en/copilot/reference/ai-models/model-comparison

Model source: **gh copilot help config**

Direct-apply mode: **true**

## Current profiles

| Key | Model | Effort | Context |
|---|---|---|---|
| orchestrator | claude-sonnet-5 | medium | default |
| quick | claude-haiku-4.5 | low | default |
| default-development | claude-sonnet-5 | medium | default |
| agentic-implementation | gpt-5.3-codex | high | default |
| deep-reasoning | claude-opus-4.8-fast | high | long_context |
| review | claude-sonnet-5 | medium | default |
| visual-ui | claude-sonnet-5 | medium | default |
| mechanical | claude-haiku-4.5 | low | default |
| triage | claude-sonnet-5 | low | default |

## Findings
- No structural problems detected.

## Suggested profile changes
- "orchestrator": "claude-sonnet-4.6" -> "claude-sonnet-5" | type: policy_preference | confidence: medium | applied: True
  - reason: Preferred monthly policy model for this task class.
- "default-development": "claude-sonnet-4.6" -> "claude-sonnet-5" | type: policy_preference | confidence: medium | applied: True
  - reason: Preferred monthly policy model for this task class.
- "deep-reasoning": "claude-opus-4.8" -> "claude-opus-4.8-fast" | type: policy_preference | confidence: medium | applied: True
  - reason: Preferred monthly policy model for this task class.
- "review": "claude-sonnet-4.6" -> "claude-sonnet-5" | type: policy_preference | confidence: medium | applied: True
  - reason: Preferred monthly policy model for this task class.
- "visual-ui": "claude-sonnet-4.6" -> "claude-sonnet-5" | type: policy_preference | confidence: medium | applied: True
  - reason: Preferred monthly policy model for this task class.
- "triage": "claude-sonnet-4.6" -> "claude-sonnet-5" | type: policy_preference | confidence: medium | applied: True
  - reason: Preferred monthly policy model for this task class.

## Applied profile changes in this run
- "orchestrator": "claude-sonnet-4.6" -> "claude-sonnet-5" (policy_preference)
- "default-development": "claude-sonnet-4.6" -> "claude-sonnet-5" (policy_preference)
- "deep-reasoning": "claude-opus-4.8" -> "claude-opus-4.8-fast" (policy_preference)
- "review": "claude-sonnet-4.6" -> "claude-sonnet-5" (policy_preference)
- "visual-ui": "claude-sonnet-4.6" -> "claude-sonnet-5" (policy_preference)
- "triage": "claude-sonnet-4.6" -> "claude-sonnet-5" (policy_preference)

## Newly available models not currently used
- "claude-sonnet-5"
- "claude-sonnet-4.5"
- "claude-fable-5"
- "claude-opus-4.8-fast"
- "claude-opus-4.7"
- "claude-opus-4.6"
- "claude-opus-4.5"
- "gpt-5.5"
- "gpt-5.4"
- "gpt-5.4-mini"
- "gpt-5-mini"
- "gemini-3.1-pro-preview"
- "gemini-3.5-flash"

## Review checklist
- [ ] Compare candidates on model-comparison page.
- [ ] Review suggested/applied model swaps for cost and quality fit.
- [ ] Keep cost-sensitive defaults unless clear quality gain is expected.
