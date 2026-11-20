---
name: track-work
description: Use when the person asks for work that changes a project (a feature, an update, a fix, a refactor) and Craft Board (the craft-board MCP server) is connected. Decides whether to track the work as a Craft Board card, asks the person once, and keeps the card and the time clock up to date.
---

# Track work in Craft Board

Craft Board is the team's project board and time clock. The `craft-board` tools act as the signed-in person and can do no more than their role allows. The team wants real work on cards and on the clock, so ask. Never track silently.

## When to ask

Ask once per task, before starting, when the request changes something: a feature, an update, a fix, a refactor, a migration. Do not ask for questions, explanations, reading or reviewing code, or when this conversation already has a card or the person already said no for this task.

## Steps

1. `git remote get-url origin`, then `find_project` with the output. One match: use it. No match or several: say so and ask which project (`list_projects`), or carry on untracked if they prefer.
2. Ask in one short line, for example: "Track this as a Craft Board card on <project>? (I'll start it In progress and clock you in if you're not.)"
3. On yes, call `start_work`:
   - `title`: the outcome in plain words, at most 80 characters ("Add voucher CSV export", not "Work on export").
   - `description`: one to three lines, what and why.
   - `notes`: the plan, short numbered steps.
   Tell the person the card code and whether you clocked them in.
4. On no, do nothing more about tracking for this task. Do not ask again.

## While working

- `add_note` for a decision, a finding, or a milestone reached. A few lines, not a log.
- Ask before: `update_card_status` (review, test, completed), `clock_out`, `add_comment`, `update_card`.
- When the work is finished, offer to add a closing note and to move the card on. Moving to `completed` may need a note and may be refused while QA has tests open; pass the refusal on in the app's own words.
- Never invent ids. Take them from `find_project`, `list_projects`, `list_cards`, `get_card` and `start_work`.

## Reading

`project_overview`, `list_cards` (with `mine`), `get_card`, `search_project_knowledge` and `time_status` read only. Use them freely to understand a project or find a card before creating a duplicate.
