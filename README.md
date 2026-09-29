# Base skills

Agent skills and the MCP server for [Base](https://createbases.com), where
an agent turns documents into a shared, cited knowledge base and people and
their agents work in one together.

## Install

Skills, for Claude Code, Codex, Cursor, and any agent that reads `SKILL.md`:

```bash
npx skills add Lucky-Tree-Labs/base-skills
```

The MCP server, which does the work the skills describe:

```bash
npx -y add-mcp https://createbases.com/api/mcp -g
```

As a Claude Code plugin, skills and MCP server together:

```
/plugin marketplace add Lucky-Tree-Labs/base-skills
/plugin install base@base-skills
```

In ChatGPT, Claude, and other hosted chats there is nothing to install from
here: add the connector. Claude lists it in its
[directory](https://claude.ai/directory/createbases); elsewhere the URL is
`https://createbases.com/api/mcp`. Setup per app: https://createbases.com/connect.

## Skills

| Skill | Use it when |
| --- | --- |
| [`create-base`](skills/create-base/SKILL.md) | Documents, URLs, or text should become a Base shared by one link. |
| [`work-in-base`](skills/work-in-base/SKILL.md) | Opening, questioning, or contributing to a Base, including a pasted `/s/` link. |

## Where the skills come from

`skills/` mirrors what createbases.com publishes at
`/.well-known/skills/index.json`. `scripts/sync.sh` pulls it and a daily
workflow opens a pull request with any change, so a skill edit made here is
replaced by the next sync.

## Contributing

Found something wrong in a skill? Open an issue, or email
support@createbases.com. Pull requests are welcome for the manifests and the
README; every change is reviewed by a maintainer before it merges.

More for agents: https://createbases.com/agents

## License

MIT
