# Assignment 1 Marking Rubric
**Total: 100 marks (scaled to 30% of unit grade)**
**Group Project: R Package Development – Rock, Paper, Scissors**

---

## 1. Functionality of `play_rps()` (20 marks)

**Excellent (17–20)**
- All requirements satisfied.
- Correct logic for win/lose/draw across multiple rounds.
- All strategies implemented correctly, including at least one stateful strategy.
- Fully robust to edge cases; input/output exactly matches specification.

**Good (13–16)**
- Gameplay correct for typical inputs; minor inconsistencies.
- Strategies implemented but one may be incomplete.

**Satisfactory (9–12)**
- Basic gameplay works but fails for some edge or mixed cases.
- Limited strategy robustness.

**Poor (1–8)**
- Incorrect outcomes or broken logic.
- Strategies malfunction or missing.

**Not attempted (0)**
- No meaningful implementation.

---

## 2. Code Quality and Design (20 marks)

**Excellent (17–20)**
- Clean, modular, readable code with appropriate helper functions.
- Good separation of concerns.
- Efficient vectorisation where appropriate.
- Sensible data structures.
- No seed-setting in package code; randomness handled properly.

**Good (13–16)**
- Mostly modular; occasional duplication.
- Some vectorisation.

**Satisfactory (9–12)**
- Limited modularity; large blocks of logic embedded in one place.
- Overuse of loops where vectorisation is feasible.

**Poor (1–8)**
- Monolithic, unstructured, or hard-to-follow code.

**Not attempted (0)**
- No coherent code submitted.

---

## 3. Documentation (roxygen2 + README) (15 marks)

**Excellent (13–15)**
- `play_rps()` clearly documented with running examples.
- README well-written and explains installation and usage.
- Examples run without errors.

**Good (10–12)**
- Documentation mostly clear; minor missing details.

**Satisfactory (7–9)**
- Documentation incomplete, unclear, or inaccurate.

**Poor (1–6)**
- Minimal documentation; examples missing or broken.

**Not attempted (0)**
- No documentation provided.

---

## 4. Unit Testing (15 marks)

**Excellent (13–15)**
- Comprehensive test coverage for gameplay logic, strategies, and edge cases.
- Tests deterministic via setting seeds *in tests only*.
- Clear organisation.

**Good (10–12)**
- Several important behaviours tested; moderate coverage.

**Satisfactory (7–9)**
- Limited or superficial tests; some randomness issues.

**Poor (1–6)**
- Very little testing; major logic untested.

**Not attempted (0)**
- No tests.

---

## 5. Package Structure and Build Quality (10 marks)

**Excellent (9–10)**
- Package builds and installs without error or significant warnings.
- Passes `R CMD check` with zero errors and warnings
- Proper structure, DESCRIPTION, and NAMESPACE.

**Good (7–8)**
- Minor notes or warnings.

**Satisfactory (5–6)**
- Noticeable structural issues; multiple notes/warnings.

**Poor (1–4)**
- Package fails check or builds incorrectly.

**Not attempted (0)**
- Package does not build.

---

## 6. GitHub Usage and Commit Practices (10 marks)

**Excellent (9–10)**
- Regular, meaningful commits from all members.
- Clear, accurate commit messages.
- Evidence of collaboration.

**Good (7–8)**
- Mostly regular commits; messages acceptable.

**Satisfactory (5–6)**
- Irregular commits; vague or mixed-quality messages.

**Poor (1–4)**
- Sparse commits; poor documentation of work.

**Not attempted (0)**
- No meaningful commit history.

*(Individual commit‑based penalties applied separately as per assignment instructions.)*

---

## 7. AI Use Statement (5 marks)

**Full marks (5)**
- Clear, honest explanation of AI use, including prompts/examples.
- No evidence of unacknowledged use.

**Partial (2–4)**
- Statement present but incomplete or unclear.

**Zero (0)**
- No statement OR unacknowledged AI use detected.
