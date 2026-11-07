# ARM Descriptor — Functional Subsystems

## Stationary station software (ПОСС)

The technical description identifies nine functional areas:

1. Information-resource interaction: authentication, requests and request translation.
2. Dossier editing: extended-attribute viewing, regulated operations, manual entry of historical addresses and address-directory use.
3. Document preview: page-layout preview and scaling.
4. Printing: character-spacing controls, MRZ-related layout and repeat printing before finalization.
5. Font tools: pixel-level font creation from bitmap glyphs and character-parameter editing.
6. Document comparison: overlay of generated and scanned documents with adjustable transparency.
7. Dossier import/export: exchange containers used by the stationary station.
8. Transformation and encryption: materials describe an AES design and a later GOST 28147-89 reference; revisions must be checked.
9. Authorization-data preparation: paired key files for ПОСС and ПОШ ВБД, with administrator access described.

## Mobile station software (ПОМС)

Three areas: gateway authentication; dossier-container import/export between VBD and ПОСС; structured wizard-style search in VBD.

## VBD gateway software (ПОШ ВБД)

Two areas: interaction with VBD, including translation of lower-level SQL requests for the PPO Territory database; and consistency validation before reverse import. The technical description refers to optimistic concurrency control and blocking import when conflicts are detected.

The specification describes intended functions; it does not prove implementation. The described total is 9 + 3 + 2 = 14 functional areas.
