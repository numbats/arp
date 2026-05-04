# Assignment 3 Marking Rubric
**Total: 100 marks (scaled to 30% of unit grade)**
**Group Project: R Package Development – dealr**

---

## 1. Package Structure, Installation, and Overall Design (10 marks)

**Excellent (9–10)**
- Valid R package structure with appropriate `DESCRIPTION`, `NAMESPACE`, R source files, tests, documentation, and vignette infrastructure.
- Package installs and loads cleanly; `R CMD check` or `devtools::check()` has no errors, no warnings, and at most minor notes.
- All required user-facing functions are exported; dependencies are declared correctly and used appropriately.
- Clear, coherent package design; no inappropriate global state; no user interactivity; no plotting; no game-specific logic; functions are predictable and composable.

**Good (7–8)**
- Package mostly well-structured but with minor metadata, namespace, or organisation problems.
- Package installs and loads; minor check warnings or notes that do not affect functionality.
- One or two minor export/dependency omissions, but most functions are accessible.
- Generally good design with minor inconsistencies or unnecessary extras.

**Satisfactory (5–6)**
- Package can be loaded only with workarounds, or has significant check warnings.
- Noticeable structural issues; some missing exports or dependency problems.
- Design is confusing, overly coupled, or inconsistent, but core requirements can still be used.

**Poor (1–4)**
- Package has substantial structural problems or cannot be loaded without significant intervention.
- Major missing exports or undeclared dependencies prevent normal use.
- Design substantially violates the assignment scope or relies heavily on inappropriate global state or interactivity.

**Not attempted (0)**
- No package structure submitted.

## 2. `card` vctrs Record Class (15 marks)

**Excellent (13–15)**
- `card` is implemented as a genuine vctrs record class using `vctrs::new_rcrd()` or equivalent, with appropriate rank and suit fields.
- `card(rank, suit)` correctly validates all required ranks and suits; accepts full suit names and one-letter abbreviations; is case-insensitive; handles vector inputs and recycling; gives informative errors for invalid inputs.
- Accessors `is_card()`, `card_rank()`, and `card_suit()` work for length-0, length-1, and longer card vectors; return documented, user-friendly ranks and suits.
- `format.card()` is correct, vectorised, stable, and readable.
- Card vectors preserve class and fields under subsetting and work correctly with concatenation, especially `vctrs::vec_c()`.
- Equality requires both rank and suit to match and works correctly for vectors, including empty and vectorised cases.
- Sorting follows Clubs < Diamonds < Hearts < Spades, then A < 2 < … < 10 < J < Q < K, using an appropriate vctrs comparison proxy or equivalent.

**Good (10–12)**
- Uses vctrs substantially correctly but with minor implementation weaknesses.
- Mostly correct validation and input handling, with minor edge-case issues.
- Accessors mostly work but have inconsistencies in case, ordering, or exposed internal encodings.
- Simple subsetting works, but concatenation or class preservation is unreliable in edge cases.
- Equality works for simple cases but has edge-case or vectorisation issues.
- Sorting mostly works but has ordering mistakes or limited-case behaviour.

**Satisfactory (7–9)**
- Uses vctrs only partially, or the object is not a well-designed record class.
- Basic valid examples work, but several required input forms or validation cases fail.
- Accessors missing or substantially incorrect for some cases.
- Subsetting or concatenation have notable issues.

**Poor (1–6)**
- No meaningful vctrs class implementation, or implementation is substantially broken.
- Constructor missing or does not return valid `card` objects.
- Formatting or sorting missing or substantially incorrect.

**Not attempted (0)**
- No meaningful `card` class implementation.

## 3. S3 Classes for `deck`, `hand`, and `deal` (10 marks)

**Excellent (9–10)**
- `deck(cards)` constructs a valid S3 object from a card vector; validates input; preserves order; has a sensible internal structure.
- `hand(cards, player)` constructs a valid S3 object; validates card input; stores player metadata appropriately; preserves order.
- `deal()` returns a well-structured S3 object containing a list of `hand` objects, a remaining `deck`, and useful metadata (players, number of cards, dealing style).
- Accessors `cards()`, `hands()`, and `remaining_deck()` are implemented cleanly; `cards()` is an S3 generic with methods for `hand` and `deck`; unsupported classes produce informative errors.
- Decks, hands, and deals consistently preserve valid internal card objects and card order across operations.

**Good (7–8)**
- Most S3 objects well-constructed; minor validation, metadata, or structure issues in one class.
- Accessors work correctly for most cases but generic/method design has minor weaknesses.
- Object invariants mostly preserved, with occasional edge-case violations.

**Satisfactory (5–6)**
- Basic `deck` and `hand` objects work, but `deal` structure is incomplete.
- Accessors work for simple cases but are ad hoc or incomplete.
- Object invariants not consistently preserved.

**Poor (1–4)**
- One or more required S3 classes missing or substantially incorrect.
- Accessors missing or substantially incorrect.

**Not attempted (0)**
- No meaningful S3 class implementation.

## 4. Deck Manipulation and Dealing Functions (10 marks)

**Excellent (9–10)**
- `standard_deck(n_decks = 1L)` correctly creates 52 cards per deck, no jokers, correct canonical order, supports multiple decks, validates `n_decks`, and returns a `deck` object.
- `shuffle_deck(deck)` returns a shuffled deck preserving all cards and count, and does not mutate the input.
- `cut_deck(deck, n)` correctly moves the first `n` cards to the bottom; preserves all cards and class; handles reasonable boundary cases.
- `deal(deck, n, players, by = c("round", "batch"))` correctly deals `n` cards to each player from the top of the deck; supports both round and batch dealing exactly as specified; returns correct hands and remaining deck; preserves card order within hands.
- `deal()` does not modify the input deck; validates players and `n`; errors informatively when there are insufficient cards or invalid arguments.

**Good (7–8)**
- Mostly correct, with minor problems in one dealing mode, validation, or edge case.
- `standard_deck()`, `shuffle_deck()`, or `cut_deck()` mostly correct with minor issues.

**Satisfactory (5–6)**
- Basic dealing works but one mode is wrong or output structure is incomplete.
- Some validation present, but important invalid cases or error messages are missed.

**Poor (1–4)**
- Major dealing functions missing or substantially incorrect.
- No meaningful validation; mutates input inappropriately.

**Not attempted (0)**
- No meaningful implementation.

## 5. `filter_cards()` and Tidy Evaluation (15 marks)

**Excellent (13–15)**
- Correctly uses tidy evaluation (e.g., `rlang::enquos()` and `rlang::eval_tidy()` or equivalent); expressions are evaluated in a data mask containing at least `rank` and `suit`; does not use `dplyr` in the implementation.
- Supports unquoted expressions such as `suit == "Hearts"`, `rank %in% c("A", "J", "Q", "K")`, and combined rank/suit filters; multiple expressions combined using logical AND; expression results validated as logical vectors of appropriate length.
- Filtering works for `card`, `hand`, and `deck` inputs; preserves input type; preserves relevant metadata such as player name; preserves original card order.
- Invalid filtering expressions produce informative errors; no-match cases return an empty object of the appropriate type.
- Implementation avoids unnecessary duplication across methods and integrates cleanly with the card/deck/hand abstractions.

**Good (10–12)**
- Uses tidy evaluation mostly correctly but with minor limitations or unnecessary complexity.
- Core expression filtering works, but some multi-expression or validation cases fail.
- Mostly preserves type/order but has minor problems for one object type or metadata.
- Empty results work, but validation or error messages have weaknesses.

**Satisfactory (7–9)**
- Attempts tidy evaluation but implementation is fragile or only partly non-standard-evaluation based.
- Only simple filtering expressions work reliably.
- Filtering works but returns the wrong type or loses important metadata.

**Poor (1–6)**
- No meaningful tidy evaluation, or simply delegates to `dplyr` contrary to instructions.
- Filtering works only for very narrow hard-coded cases, or required methods are missing.

**Not attempted (0)**
- No meaningful `filter_cards()` implementation.

## 6. Data Frame Conversion and Printing Methods (10 marks)

**Excellent (9–10)**
- `as.data.frame()` methods for `card`, `deck`, and `hand` all return data frames with appropriate columns, correct row counts, and stable behaviour for empty objects.
- `hand` conversion preserves card order and includes useful player metadata.
- All required print methods for `card`, `deck`, `hand`, and `deal` are present, readable, concise, and do not expose confusing internals.
- Display and conversion methods handle empty objects, multiple decks, and simple edge cases without error.

**Good (7–8)**
- `as.data.frame()` methods mostly correct; minor column naming, ordering, or edge-case issues in one method.
- Print methods mostly present and usable but uneven, verbose, or missing one minor feature.

**Satisfactory (5–6)**
- Some conversion methods work but lose order, metadata, or have inconsistent columns.
- Some print methods present but incomplete or not user-friendly.

**Poor (1–4)**
- Most conversion or print methods missing or broken.

**Not attempted (0)**
- No meaningful data frame conversion or printing methods.

## 7. Unit Tests (10 marks)

**Excellent (9–10)**
- Comprehensive test coverage including all required test cases: invalid ranks/suits error; `standard_deck(n_decks = 2L)` has 104 cards; `shuffle_deck()` preserves the set of cards and count; `cut_deck()` preserves all cards and changes order as documented; `deal()` does not modify the input deck; correct number of hands and cards per hand; remaining deck has the correct card count; round and batch dealing produce the documented positions; dealing too many cards produces an informative error; `filter_cards()` works with unquoted expressions and preserves input type.
- Tests cover class preservation, subsetting, concatenation, equality, sorting, and accessors.
- Good edge-case coverage (empty selections, invalid `n_decks`, invalid `n`, invalid players, invalid card inputs, unsupported object types).
- Tests are clear, deterministic, well-organised, and integrated into normal package testing.

**Good (7–8)**
- Most required test cases covered; some class-behaviour tests present; some edge cases tested.
- Tests mostly clear and runnable with minor organisation or coverage gaps.

**Satisfactory (5–6)**
- Some required tests present but substantial gaps; limited class-behaviour or edge-case testing.
- Tests somewhat brittle or poorly organised.

**Poor (1–4)**
- Very limited testing; major logic untested; tests may not run reliably.

**Not attempted (0)**
- No meaningful tests.

## 8. Documentation and Vignette (10 marks)

**Excellent (9–10)**
- All user-facing functions documented with clear descriptions, parameters, return values, and runnable examples.
- Examples are accurate, runnable, and demonstrate typical usage across the package.
- Vignette clearly explains the package workflow: card creation, deck creation, shuffling/cutting, dealing, and filtering.
- Documentation is consistent with implemented behaviour and assignment terminology, with clear prose and formatting.

**Good (7–8)**
- Most functions documented with minor omissions or weak examples.
- Vignette present and useful but misses some important workflow elements.
- Documentation mostly consistent with minor inaccuracies.

**Satisfactory (5–6)**
- Some documentation present but several exported functions are missing important details.
- Vignette present but incomplete, superficial, or difficult to follow.

**Poor (1–4)**
- Minimal documentation only; examples absent, broken, or misleading.
- No meaningful vignette.

**Not attempted (0)**
- Little or no documentation.

## 9. GitHub Workflow, Commits, and AI Statement (10 marks)

**Excellent (9–10)**
- Repository shows regular, meaningful commits throughout the assignment period, with informative messages and appropriately scoped changes.
- All team members have at least six substantive commits across multiple days reflecting meaningful contributions to code, documentation, or tests.
- `AI_statement.md` is present, has a section for each student, and appropriately describes AI use including prompts, or clearly states that no AI was used.
- Repository is organised, avoids committing generated clutter or irrelevant files, and shows evidence of sensible collaboration practices.

**Good (7–8)**
- Good commit history with minor issues (vague messages, occasional large commits).
- All or most team members contributed meaningfully, but one member's contribution is slightly marginal or concentrated.
- AI statement present but incomplete, vague, or missing one student's section.

**Satisfactory (5–6)**
- Development is uneven, too concentrated near the deadline, or commit messages are often vague.
- Contribution is substantially uneven, with limited evidence from one or more members.
- AI statement does not adequately describe how AI was used.

**Poor (1–4)**
- Very sparse or mostly last-minute commits.
- Little or no evidence of genuine group contribution.
- AI statement missing or substantially incomplete.

**Not attempted (0)**
- No meaningful commit history or AI statement.

*(Individual commit-based penalties applied separately as per assignment instructions.)*

---

# Additional Marker Notes

## Suit and rank case

The constructor must be case-insensitive. Internally, students may store suits as lowercase, title case, or codes, provided user-facing accessors, formatting, sorting, and filtering behave consistently with the documentation.

## Empty card vectors

Strong solutions should handle empty card vectors gracefully, especially through filtering and data-frame conversion. Award robustness credit where appropriate, but do not over-penalise if all required examples work and only obscure empty cases fail.

## `deal()` and mutation

The input deck should not be modified in place. Because ordinary R objects are copy-on-modify, most solutions will naturally satisfy this.

## Individual contribution deductions

If a team member has not contributed adequately, apply a deduction of up to 75% of that student's total mark, as specified in the assignment instructions. Consider the number, timing, and substance of commits, not just the raw count. Minor typo/formatting commits should not count as substantive contributions.
