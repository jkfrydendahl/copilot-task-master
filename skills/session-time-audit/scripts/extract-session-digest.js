// Builds a text digest for one Copilot CLI session from the local session store,
// combining checkpoint overviews (best summaries), all user messages (truncated),
// and the final assistant response.
//
// Usage: node extract-session-digest.js <session-id>
// Output: a single JSON object on stdout: { id, project, title, created_at, updated_at,
//          n_turns, n_checkpoints, digest }
//
// Requires Node's built-in node:sqlite module (Node 22.5+ with --experimental-sqlite,
// or Node 23.4+ where it is unflagged). If your Node version lacks node:sqlite, install
// a `sqlite3` CLI and adapt this script, or query via the `session_store_sql` tool
// (source: local) inside the Copilot CLI session instead -- it exposes the same
// `sessions` / `turns` / `checkpoints` tables.

const { DatabaseSync } = require('node:sqlite');
const path = require('path');

function truncate(s, n) {
  if (!s) return '';
  s = String(s);
  return s.length > n ? s.slice(0, n) + '…[truncated]' : s;
}

function main() {
  const sessionId = process.argv[2];
  if (!sessionId) {
    console.error('Usage: node extract-session-digest.js <session-id>');
    process.exit(1);
  }

  const dbPath = path.join(process.env.USERPROFILE, '.copilot', 'session-store.db');
  const db = new DatabaseSync(dbPath, { readOnly: true });

  const session = db.prepare(`SELECT id, repository, summary, created_at, updated_at FROM sessions WHERE id = ?`).get(sessionId);
  if (!session) {
    console.log(JSON.stringify({ error: `No session found with id ${sessionId} in ${dbPath}` }));
    db.close();
    return;
  }

  const turns = db.prepare(`SELECT turn_index, user_message, assistant_response, timestamp FROM turns WHERE session_id = ? ORDER BY turn_index`).all(sessionId);
  const checkpoints = db.prepare(`SELECT checkpoint_number, title, overview FROM checkpoints WHERE session_id = ? ORDER BY checkpoint_number`).all(sessionId);
  db.close();

  let digestParts = [];
  if (checkpoints.length > 0) {
    digestParts.push('--- CHECKPOINT OVERVIEWS ---');
    for (const c of checkpoints) {
      digestParts.push(`[Checkpoint ${c.checkpoint_number}: ${c.title}]\n${c.overview}`);
    }
  }
  digestParts.push('--- USER MESSAGES (chronological, truncated) ---');
  for (const t of turns) {
    if (t.user_message && t.user_message.trim().length > 0) {
      digestParts.push(`(turn ${t.turn_index}) ${truncate(t.user_message.trim(), 400)}`);
    }
  }
  const lastAssistant = [...turns].reverse().find(t => t.assistant_response && t.assistant_response.trim().length > 0);
  if (lastAssistant) {
    digestParts.push('--- LAST ASSISTANT RESPONSE (truncated) ---');
    digestParts.push(truncate(lastAssistant.assistant_response.trim(), 1500));
  }

  console.log(JSON.stringify({
    id: session.id,
    project: session.repository,
    title: session.summary,
    created_at: session.created_at,
    updated_at: session.updated_at,
    n_turns: turns.length,
    n_checkpoints: checkpoints.length,
    digest: digestParts.join('\n\n'),
  }, null, 2));
}

main();
