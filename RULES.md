# Repository Workflow Rules

These rules keep development consistent across the project. The document is intentionally brief so it can be referenced often.

## General Principles

- Follow Test-Driven Development. Write tests before production code and keep changes small.
- Use strict TypeScript and prefer immutable patterns.
- When looking for solutions, consult **context7** and the guidance in **MEMORY.md**. Do not copy text from MEMORY.md into this file.

## Local Workflow

All automation must rely only on the tools committed in this repository or those already available on the system. **Do not use npm or any other package manager.**

Use the helper scripts under `scripts/` during feature work:

- `scripts/check-links.sh` – ensure documentation links are valid
- `scripts/check-trailing-whitespace.sh` – identify trailing spaces in Markdown
- `scripts/run-ci-checks.sh` – run link and whitespace checks on all Markdown files

Run the provided scripts and any tests before pushing changes. CI mirrors these commands.

## Commit Standards

Commits must use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/). Examples:

```
feat: add dark mode toggle
fix: handle null todo values
chore: update dependencies
```

## Pull Requests

Prefix PR titles to show intent:

- **Feature:** … → merge into `develop`
- **Bugfix:** … → merge into `develop`
- **Cleanup:** … → merge into `develop`
- **Pipeline:** … → merge into `develop`
- **Hotfix:** … → merge directly to `main`

Include a **Codex CI** section summarising `install`, `build`, `typecheck`, and `test` results.

After merging into `develop`, automatically open a PR that merges `develop` into `main` so changes can be tested against the main branch.

## Continuous Integration

CI jobs use the same helper scripts and do **not** install dependencies with package managers. The Super-Linter runs on every pull request via `.github/workflows/super-linter.yml`.
The workflow in `.github/workflows/scripts-ci.yml` runs `scripts/run-ci-checks.sh` on every push and pull request.

Find ways to mitigate any current Super-Linter failures as we continue to make incremental changes. However, failures should not mean we break existing functionality and the way the UI looks today. Take a balanced approach here.
