# ARM Descriptor — Mobile Station UI and Search Workflow

The described interface contains three tabs: **Search parameters**, **Search results (count)** and **Export dossiers (count)**.

## Search criteria

- Personal data: birth/death dates, sex, place of birth and name.
- Identity documents: type, issuing authority, series, number, issue date, validity dates and first/last-document indicators.
- Addresses: type, effective date, locality, street and premises.

## Results and selection

The result list is described as showing row number, name, birth/death dates, place of birth, latest document and a concealment indicator. A context command adds selected rows to the export queue. Opening a result displays a dossier view with personal details and document history.

## Export

The described export action opens a Save As dialog and offers `Umms transfer file (*.ummstr)`. The interface also shows commands to export and clear the queue.

Screenshots do not establish backend query semantics (such as AND/OR behavior), transaction behavior, internal memory structures or secure deletion. Those require source-code or test evidence.
