# Craft Board for Claude Code

Track your Claude Code work in Craft Board (CPMS). When you ask Claude to change a project, it asks once whether to track it as a Kanban card. On yes it creates the card **In progress**, assigned to you, adds the plan as a note, and clocks you in if you aren't. It can also read and update your projects as you, asking before it changes anything. It can do no more than your role allows.

## Install

In Claude Code:

```
/plugin marketplace add cyclomax-x/cpms-official-plugin
/plugin install craft-board@cyclomax
```

Then `/mcp`, choose `craft-board`, and sign in. A browser tab opens: log in to Craft Board as usual and press **Connect**. Claude Code keeps you signed in and refreshes the sign-in by itself.

Only the server, without the plugin's reminder and skill:

```
claude mcp add --transport http craft-board https://3.6.88.110/CPMS/api/mcp
```

## What Claude can do

| Reads | Writes (Claude Code asks first) |
|---|---|
| `whoami`, `time_status` | `start_work` (card + note + clock-in) |
| `find_project` (by git origin), `list_projects`, `project_overview` | `add_note`, `add_comment` |
| `list_cards`, `get_card` | `update_card_status`, `update_card`, `update_related_task` |
| `search_project_knowledge` | `clock_in`, `clock_out` |

There is no delete tool. Moving a card follows the board's own rules, and only someone who works on a card (assigned, its creator, or the project's manager) can move it.

## Why a hook

The server tells Claude when to ask. A small hook (`hooks/track-work.sh`) repeats it once per session with this repository's origin, because a reminder next to the first prompt is followed more reliably than instructions read at connect time. It adds text for Claude and does nothing else: no network, no files outside the temp folder.

## Disconnect

`/mcp`, choose `craft-board`, **Clear authentication**. Remove the plugin with `/plugin uninstall craft-board`.
