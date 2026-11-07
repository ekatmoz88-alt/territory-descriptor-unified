# Verification Matrix

| Evidence level | What it can establish | What it cannot establish alone |
|---|---|---|
| Technical-project description | Intended architecture, requirements and specified functions | Implementation or deployment |
| UI screenshot | Visible controls, labels and user workflow | Backend behavior, transaction semantics or data integrity |
| Actual XML/BMP sample | Structure and values in that specific file | Full format compatibility or runtime use |
| Source code | Implemented logic in the examined revision | Successful operation in a deployed environment |
| Tests and logs | Behavior under recorded test conditions | Behavior outside tested conditions |

## Review rules

- Keep requirements separate from implementation findings.
- Record source revision, file path and test conditions where available.
- Do not infer query semantics from a filter screen.
- Do not infer encryption, secure deletion or transaction guarantees from a file dialog.
- Do not treat a project name or extension as proof that two independent systems share an architecture.
