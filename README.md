# homebrew-kiln

Homebrew tap for [Kiln](https://kiln-games.com/studio) — a desktop app for
making games by describing them to an agent.

## Install

```sh
brew install --cask haakofli/kiln/kiln
```

This installs the current release's DMG from `kiln-games.com` and clears the
macOS quarantine attribute in a `postflight` step. The builds are ad-hoc signed
rather than notarized, and Homebrew 5 removed `--no-quarantine`, so without that
step Gatekeeper would refuse to open the app on first launch.

## Requirements

- **Apple Silicon only** (`arm64`). An Intel Mac is turned away by the cask
  rather than given an app that cannot start.
- macOS Big Sur (11) or later.

## Updating

Kiln updates itself. When there is a newer version, a button in the status bar
downloads it, installs it and restarts — nothing to do here.

The cask says `auto_updates true`, so a plain `brew upgrade` leaves Kiln alone
instead of putting an older DMG over an app that has already moved past it.
`brew upgrade --cask kiln` still works whenever you want Homebrew to do it.

## Uninstalling

`brew uninstall --cask kiln` removes the app. `--zap` also removes Kiln's own
settings, caches and web data under `~/Library`. Neither ever touches
`~/Documents/Kiln Games` — those are your games, not Kiln's data.

## Maintainer notes

**`Casks/kiln.rb` is written by the kiln-games site on every publish. Never
hand-edit it** — the next publish overwrites the whole file, not two lines of it.

- The template is `src/lib/cask.ts` in the kiln-games repository. Structural
  changes (stanzas, `zap` entries, the postflight) go there.
- `src/lib/tap.ts` writes it here through the GitHub contents API, authenticated
  with the `HOMEBREW_TAP_TOKEN` secret: a fine-grained personal access token with
  **Contents: read and write** on `haakofli/homebrew-kiln` and nothing else. The
  target repository is `TAP_REPO` in the site's `wrangler.jsonc`.
- A failed write does not fail the publish. The release goes live and
  `/admin/releases` says the tap is out of step, with a **write the cask** button
  to try again. A stale cask does not error — it installs the previous version —
  so that warning is the only symptom there is.
- **The first cask** arrives by pressing **write the cask** on the current
  release at `/admin/releases`. Until then this repository holds only this
  README, and `brew install` finds nothing to install.
