# Data Problems from the Field

Practice projects based on real data engineering problems: the kind where the pipeline is green, the tests pass, and the number is still wrong.

Each folder is a small, self-contained project with a planted problem. You get a working setup, a symptom, a task and a "done when" checklist. No slides, no theory first. Run it, find what's wrong, fix it, and add the check that would have caught it.

These go with my weekly LinkedIn series of the same name. I've been building software and data platforms since 2016, and the problems here are simplified versions of things I've hit in production.

## Problems

| # | Problem | Tools | Level |
|---|---|---|---|
| 01 | [The join that doubled revenue](01-join-doubled-revenue) | dbt, DuckDB, SQL | Beginner |
| 02 | The replication slot that ate the disk | Postgres, Debezium, Docker | Coming 24 Nov |
| 03 | "Read-only" is not a prompt | SQL, an LLM, MCP | Coming 1 Dec |
| 04 | A backup you haven't restored | Postgres, Docker | Coming 8 Dec |

## How to use this

1. Clone the repo and open a problem folder.
2. Follow its README: setup, task, "done when".
3. Use the hints only when you're stuck. They go from small nudges to near answers.
4. When you're done, compare with the `solutions` branch. Yours doesn't have to match. If it ticks every box on the checklist, it's a solution.

Everything runs locally and the datasets are small. You don't need a cloud account.

## Sharing your work

Push your solution to your own fork and put it on your CV or GitHub profile. A short write-up of what was wrong and how you found it is worth more than the code.

If you think something's wrong in a problem, or you have a production story that would make a good one, open an issue.

## Author

Kashif Sohail, data platform engineer. [kashifsohail.com](https://kashifsohail.com) · [LinkedIn](https://www.linkedin.com/in/kshfse/)

## License

MIT
