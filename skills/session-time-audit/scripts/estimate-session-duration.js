// Computes wall-clock span and an "active time" estimate for one Copilot CLI session
// from its events.jsonl event log.
//
// Usage: node estimate-session-duration.js <session-id>
// Output: a single JSON object on stdout.
//
// Method: sum only consecutive-event gaps <= IDLE_GAP_MIN as "active" time. Longer gaps
// are treated as idle/away (the user stepped away, was in a meeting, etc.) and excluded.
// This is a judgment call, not a measurement -- treat active_min_est as an estimate.

const fs = require('fs');
const path = require('path');
const readline = require('readline');

const IDLE_GAP_MIN = 10.0;

async function main() {
  const sessionId = process.argv[2];
  if (!sessionId) {
    console.error('Usage: node estimate-session-duration.js <session-id>');
    process.exit(1);
  }

  const fpath = path.join(process.env.USERPROFILE, '.copilot', 'session-state', sessionId, 'events.jsonl');
  if (!fs.existsSync(fpath)) {
    console.log(JSON.stringify({ error: `No events.jsonl found for session ${sessionId}`, path: fpath }));
    return;
  }

  const timestamps = [];
  const lifecycle = [];
  let n_events = 0, n_tool_calls = 0, n_user_msgs = 0, n_assistant_msgs = 0;

  const rl = readline.createInterface({ input: fs.createReadStream(fpath, { encoding: 'utf8' }), crlfDelay: Infinity });
  for await (const line of rl) {
    const trimmed = line.trim();
    if (!trimmed) continue;
    let o;
    try { o = JSON.parse(trimmed); } catch { continue; }
    const ts = o.timestamp;
    if (!ts) continue;
    const dt = Date.parse(ts);
    if (Number.isNaN(dt)) continue;
    n_events++;
    timestamps.push(dt);
    const t = o.type || '';
    if (t === 'session.start' || t === 'session.resume' || t === 'session.shutdown') lifecycle.push([t, dt]);
    if (t === 'tool.execution_start') n_tool_calls++;
    else if (t === 'user.message') n_user_msgs++;
    else if (t === 'assistant.message') n_assistant_msgs++;
  }

  if (timestamps.length === 0) {
    console.log(JSON.stringify({ error: 'events.jsonl had no parsable timestamped events', path: fpath }));
    return;
  }

  timestamps.sort((a, b) => a - b);
  const first = timestamps[0], last = timestamps[timestamps.length - 1];
  const wall_span_min = (last - first) / 60000;

  let active_min = 0;
  for (let i = 1; i < timestamps.length; i++) {
    const gap = (timestamps[i] - timestamps[i - 1]) / 60000;
    if (gap <= IDLE_GAP_MIN) active_min += gap;
  }

  let n_blocks = lifecycle.filter(([t]) => t === 'session.start' || t === 'session.resume').length;
  if (n_blocks === 0) n_blocks = 1;

  console.log(JSON.stringify({
    session_id: sessionId,
    n_events,
    n_tool_calls,
    n_user_msgs,
    n_assistant_msgs,
    n_blocks,
    wall_span_min: Math.round(wall_span_min * 10) / 10,
    active_min_est: Math.round(active_min * 10) / 10,
    idle_gap_threshold_min: IDLE_GAP_MIN,
    first: new Date(first).toISOString(),
    last: new Date(last).toISOString(),
  }, null, 2));
}

main();
