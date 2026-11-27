# ARM Descriptor — Font Simulation and Print Workflow

## Font configuration

The described `DescriptorFont` XML includes font name, DPI, character spacing, pair-specific spacing and baseline shifts. Example materials show Courier New at size 15 and per-character adjustments.

## Bitmap glyph library

The materials describe individual glyphs stored as monochrome BMP files. Example dimensions include 43×43, 29×48 and 38×43 pixels. The editing interface presents a discrete pixel grid for manual glyph editing.

## Document layout

The described editor exposes passport-page tabs (including pages labelled 2, 3, 5/12, 16 and 17) and controls for X/Y position in centimetres, font size and user-defined text.

A screenshot confirms visible controls, not rendering accuracy. Actual XML/BMP files confirm only their own structure. Source code and print tests are needed to establish rendering, kerning, coordinate accuracy and physical output.
