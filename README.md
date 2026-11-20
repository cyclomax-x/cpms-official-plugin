# Cyclomax plugins for Claude Code

Public home of the Claude Code plugins for Craft Board (CPMS). The Craft Board app itself is in a private repository; this one holds only the plugin, so anyone can install it.

| Plugin | What it does |
|---|---|
| [`craft-board`](craft-board/README.md) | Track your Claude Code work on Craft Board cards and the time clock |

## Install

In Claude Code:

```
/plugin marketplace add cyclomax-x/cpms-official-plugin
/plugin install craft-board@cyclomax
```

Then `/mcp`, choose `craft-board`, and sign in with your Craft Board login. See [craft-board/README.md](craft-board/README.md).

The plugin contains no secrets: the address of the Craft Board server, a small reminder hook and a skill. Signing in is done by each person in the browser.
