Use `ketch` CLI from `bash` for all external research — web pages, OSS code,
library docs.

- Web search: `ketch search "<query>"` — titles, URLs, snippets
- Scrape: `ketch scrape "<url>"` — fetches a URL and returns clean markdown
- Batch scrape: `ketch scrape "<url1>" "<url2>" ...` — concurrent fetch
- Crawl: `ketch crawl "<url>" --sitemap --background` — crawl a site, poll with
  `ketch crawl status`
- Code search: `ketch code "<query>" --lang go` — real OSS code with line +
  repo + stars
- Library docs: `ketch docs "<query>" --library /org/repo` — version-aware
  curated snippets
- JS-rendered pages are handled automatically — if a page returns a loading
  shell, ketch re-fetches it with a headless browser.
- All commands support `--json` for structured output.
- Discovery: `ketch config` — returns effective config and available backends as
  JSON.
- The operator has already configured the search/code/docs backends and browser.
  Do not override unless you have a specific reason.
