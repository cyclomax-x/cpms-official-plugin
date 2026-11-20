#!/usr/bin/env bash
# Craft Board: on the first prompt of a session in a git repository, tell Claude the repository's
# origin and that no card tracks this session yet, so it asks the person once. A hook cannot call
# the Craft Board tools or ask anything itself; it only adds this context. It never fails a prompt.
#
#   track-work.sh prompt   UserPromptSubmit: add the context once per session
#   track-work.sh reset    SessionStart (resume, compact): ask again, the earlier answer may be gone

mode="${1:-prompt}"
input="$(cat 2>/dev/null)"

field() { printf '%s' "$input" | grep -o "\"$1\"[[:space:]]*:[[:space:]]*\"[^\"]*\"" | head -n 1 | sed 's/^[^:]*:[[:space:]]*"//; s/"$//'; }

session="$(field session_id)"
cwd="$(field cwd)"
[ -n "$session" ] || exit 0
state="${TMPDIR:-/tmp}/craft-board-track-${session}"

if [ "$mode" = "reset" ]; then
  rm -f "$state"
  exit 0
fi

# Once per session
[ -e "$state" ] && exit 0

# Only inside a git repository that has an origin
[ -n "$cwd" ] && cd "$cwd" 2>/dev/null || exit 0
origin="$(git remote get-url origin 2>/dev/null)" || exit 0
[ -n "$origin" ] || exit 0
# Never pass a token that is part of the address
origin="$(printf '%s' "$origin" | sed -E 's#(https?://)[^/@]+@#\1#')"

: > "$state" 2>/dev/null

context="Craft Board is connected as the MCP server craft-board. This repository's git origin is ${origin}. No Craft Board card tracks this session yet. When the request changes the project (a feature, update, fix or refactor), the person is asked once whether to track it as a card: find_project with this origin, then start_work if they say yes. Questions, explanations and reading code need no card."

# JSON-escape the context (backslash and double quote)
escaped="$(printf '%s' "$context" | sed 's/\\/\\\\/g; s/"/\\"/g')"
printf '{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"%s"}}\n' "$escaped"
exit 0
