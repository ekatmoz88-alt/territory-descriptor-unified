# ARM Descriptor — Data Exchange and Formats

## Transfer container

The interface materials show the `.ummstr` extension and the description “UMMSTR (Umms transfer file)”. A visible file type confirms the user-facing export option, not the internal container schema or cryptographic implementation.

## Font configuration XML

The described `DescriptorFont` structure includes `Name`, `Dpi` (120 shown as a baseline), `CharSpacing`, `CharPairSpacings` with `FirstChar`, `SecondChar` and `Spacing`, and `CharBaselineShifts` for baseline adjustments. Examples mention Cyrillic characters Ц, Щ and Д.

## Exchange boundary

The described operational path uses removable media between mobile and stationary stations. Container internals, encryption mode, integrity protection and deletion behavior require verification against actual files, source code or tests.

The `.ummstr` extension and “Umms” label do not establish that this project is the separate Passport / UMMS SOAP system.
