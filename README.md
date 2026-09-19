# humanizer-skill

A Claude Code skill for editing text in three domains that get treated as
one job but aren't:

- **Human-facing prose** (docs, PR/commit bodies, chat responses,
  user-facing CLI and error text) — removing AI writing tells (em-dashes,
  "delve", not-X-but-Y contrasts, forced triads, and 21 other patterns).
  This part adapts [blader/humanizer](https://github.com/blader/humanizer)
  (MIT), whose patterns come from Wikipedia's ["Signs of AI
  writing"](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing).
- **Code comments and docstrings** — a different failure mode entirely:
  not phrasing, but content. Chain-of-thought narration, restated syntax,
  and conversational filler get cut, not polished. What's non-obvious-why,
  function/class purpose, and error-handling rationale gets kept.
- **Machine and LLM-context text** — prompts fed to another model call,
  machine-parsed config, structured log fields. Explicitly left alone;
  editing this text risks changing program behavior, not just tone.

See `SKILL.md` for the full skill, including the classification step that
decides which domain a given span falls into (a single source file
routinely has all three side by side).

## Install

```sh
git clone git@github.com:juanman2/humanizer-skill.git ~/src/humanizer-skill
~/src/humanizer-skill/install.sh
```

The repo lives at `~/src/humanizer-skill`, not
`~/.claude/skills/humanizer` directly — `install.sh` symlinks the latter
to it (backing up, never overwriting, anything already there).

## License

MIT for this repo's own content. Sections A-E of `SKILL.md` are adapted
from `blader/humanizer`, also MIT — see `LICENSE` and
`THIRD-PARTY-NOTICES.md`.
