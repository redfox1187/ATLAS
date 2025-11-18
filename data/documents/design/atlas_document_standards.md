# atlas document standards

**project:** atlas  
**status:** draft  
**version:** v0.1  
**last_updated:** 2025-11-18  

---

## 1. scope

This document defines standards for human-readable documents in the ATLAS project.  
It covers:

- design and standards documents
- guides and how-to documents
- notes and brainstorming documents
- reports stored in the repository

All such documents are written in Markdown (`.md`) format and stored under `data/documents/` or in the repository root where explicitly specified.

---

## 2. document types and locations

ATLAS uses three main classes of documents, plus a central collaboration brief.

### 2.1 design and standards documents

Path:

- `data/documents/design/`

Purpose:

- define rules, conventions, and systems for the project  
- provide guides for how to implement or work with specific systems

Filenames follow the rules in `atlas_filename_standards.md` and typically use the following patterns:

- `atlas_<topic>_standards.md` for standards documents  
- `atlas_<topic>_guide.md` for how-to or procedural guides

### 2.2 notes

Path:

- `data/documents/notes/`

Purpose:

- capture ideas, brainstorming, and exploratory notes related to ATLAS
- record early design thoughts before they are promoted to formal standards or guides

Filenames follow the pattern:

- `atlas_<topic>_notes.md`

### 2.3 reports

Path:

- `data/documents/reports/`

Purpose:

- record specific work sessions, refactors, investigations, bug hunts, or contextual narratives
- provide detailed background information and reasoning for changes that affect the project

Filenames follow the old FQX-style pattern defined in `atlas_filename_standards.md`:

- `YYYY-MM-DD_atlas-report_<slug>_vNN.md`

Reports are not intended for direct engine consumption and exist purely to preserve context and history.

### 2.4 qorders

Path:

- repository root

Filename:

- `qorders.md`

Purpose:

- act as the central collaboration brief for ATLAS
- describe high-level goals, working rules, and pointers to other standards

`qorders.md` is expected to be read before working on ATLAS-related tasks and updated as standards evolve.

---

## 3. document header format

All ATLAS documents should begin with a standard header to provide clear context and versioning.

General header pattern:

```markdown
# <document title>

**project:** atlas  
**status:** draft  
**version:** v0.1  
**last_updated:** YYYY-MM-DD  
```

- `document title` should be human-readable and may include spaces.  
- `status` may be `draft`, `active`, `deprecated`, or similar states as needed.  
- `version` tracks human-facing revisions to the document content (e.g. `v0.1`, `v0.2`, `v1.0`).  
- `last_updated` provides a quick reference for freshness.

Reports may include additional metadata fields such as `context`, `session`, or `author` when useful, but should still follow the basic header shape.

---

## 4. document body structure

Document structure can vary by document type, but the following conventions apply.

### 4.1 standards documents

Standards documents (such as `atlas_filename_standards.md` or `atlas_code_standards.md`) should generally include:

1. **scope** – what the document covers and what it does not.  
2. **core rules** – the main standards and constraints.  
3. **examples** – concrete, representative examples.  
4. **relationships** – references to related documents or systems.  
5. **revision_history** – summary of changes over time.  
6. **footer** – file identity block (see section 6).

Standards documents should be written as impersonal references, using clear section headings and lists where appropriate.

### 4.2 guides

Guides (`atlas_<topic>_guide.md`) are more procedural. A typical guide structure:

1. **scope** – what the guide teaches or explains.  
2. **prerequisites** – required knowledge, files, or setup.  
3. **workflow** – ordered steps or phases.  
4. **examples** – code snippets, paths, or screenshots described in text.  
5. **troubleshooting / tips** – common pitfalls or variations.  
6. **revision_history**.  
7. **footer**.

Guides may be more conversational in style but should still remain clear and structured.

### 4.3 notes

Notes (`atlas_<topic>_notes.md`) are allowed more flexibility, but should still include:

- a header with project, status, version, and last_updated  
- at least a short **scope** or **summary** section  
- a rough structure grouping related thoughts or topics

Notes are not required to be as strictly structured as standards or guides, but they should still be readable and navigable.

### 4.4 reports

Reports combine aspects of logs and narratives. Recommended structure:

1. **scope** – what the report covers (e.g. a refactor, debugging session, or feature pass).  
2. **background / context** – why the work was undertaken.  
3. **process / actions taken** – ordered or grouped description of the work.  
4. **outcomes** – results, decisions, open issues, and follow-up tasks.  
5. **links / references** – related code files, scenes, or other documents.  
6. **revision_history**.  
7. **footer**.

Reports benefit from timestamps in the filename and concise “patch note” descriptions in the body.

---

## 5. revision history

Every ATLAS document should contain a `revision_history` section near the end, summarizing the evolution of the content.

Example:

```markdown
## revision_history

- **v0.1 — 2025-11-18**  
  - initial draft of document standards for ATLAS.
```

When content is updated in a meaningful way:

- increment the `version` value in the header (e.g. `v0.1` → `v0.2`)  
- update `last_updated`  
- add a new entry to `revision_history` describing the change

Entries should be short and descriptive, similar to patch notes.

---

## 6. document footer

All ATLAS documents should end with a simple footer that confirms file identity and provides a quick reference when comparing files side-by-side or checking for truncation.

Recommended footer pattern:

```markdown
---

file: <project-relative-path>  
version: vX.Y  
last_updated: YYYY-MM-DD  
```

Examples:

```markdown
---

file: data/documents/design/atlas_document_standards.md  
version: v0.1  
last_updated: 2025-11-18  
```

For reports:

```markdown
---

file: data/documents/reports/2025-11-18_atlas-report_player_controller_initial_v01.md  
version: v0.1  
last_updated: 2025-11-18  
```

The footer marks the clear end of the document and assists in detecting incomplete copies or truncation.

---

## 7. coordination with other standards

- Filename rules and patterns are defined in:  
  `data/documents/design/atlas_filename_standards.md`

- Code file structure, headers, footers, and changelog conventions are defined in:  
  `data/documents/design/atlas_code_standards.md`

These three documents are intended to function together as a unified manual for documentation and file handling in ATLAS.

---

## revision_history

- **v0.1 — 2025-11-18**  
  - initial draft of document standards for ATLAS, including headers, body structure, revision history, and footers.

---

file: data/documents/design/atlas_document_standards.md  
version: v0.1  
last_updated: 2025-11-18  
