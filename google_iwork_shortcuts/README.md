# Google Shortcuts for Apple Pages, Numbers, and Keynote

This folder provides ready-to-use macOS property list files (`.plist`) and setup scripts to remap Apple Pages, Numbers, and Keynote shortcuts to match Google Docs, Sheets, and Slides conventions.

---

## 1. Shortcut Comparison & Mapping

### A. Apple Pages $\leftrightarrow$ Google Docs
| Function | Google Docs Shortcut | Apple Pages Default | New Shortcut in Pages | AppKit Key Code |
| :--- | :--- | :--- | :--- | :--- |
| **Align Left** | `⌘ + Shift + L` | `⌘ + {` | `⌘ + Shift + L` | `@$l` |
| **Align Center** | `⌘ + Shift + E` | `⌘ + \|` | `⌘ + Shift + E` | `@$e` |
| **Align Right** | `⌘ + Shift + R` | `⌘ + }` | `⌘ + Shift + R` | `@$r` |
| **Justify** | `⌘ + Shift + J` | `⌥ + ⌘ + \|` | `⌘ + Shift + J` | `@$j` |
| **Paste without Formatting** | `⌘ + Shift + V` | `⌥ + ⇧ + ⌘ + V` | `⌘ + Shift + V` | `@$v` |
| **Strikethrough** | `⌘ + Shift + X` | `⌃ + ⇧ + ⌘ + -` | `⌘ + Shift + X` | `@$x` |
| **Subscript** | `⌘ + ,` | `⌃ + ⌘ + -` | `⌘ + ,` | `@,` |
| **Superscript** | `⌘ + .` | `⌃ + ⇧ + ⌘ + +` | `⌘ + .` | `@.` |
| **Insert Comment** | `⌥ + ⌘ + M` | `⇧ + ⌘ + K` | `⌥ + ⌘ + M` | `@~m` |
| **Insert Footnote** | `⌥ + ⌘ + F` | *(none)* | `⌥ + ⌘ + F` | `@~f` |
| **Show Word Count** | `⌘ + Shift + C` | *(none)* | `⌘ + Shift + C` | `@$c` |

---

### B. Apple Numbers $\leftrightarrow$ Google Sheets
| Function | Google Sheets Shortcut | Apple Numbers Default | New Shortcut in Numbers | AppKit Key Code |
| :--- | :--- | :--- | :--- | :--- |
| **Align Center** | `⌘ + Shift + E` | `⌘ + \|` | `⌘ + Shift + E` | `@$e` |
| **Align Left** | `⌘ + Shift + L` | `⌘ + {` | `⌘ + Shift + L` | `@$l` |
| **Align Right** | `⌘ + Shift + R` | `⌘ + }` | `⌘ + Shift + R` | `@$r` |
| **Justify** | `⌘ + Shift + J` | `⌥ + ⌘ + \|` | `⌘ + Shift + J` | `@$j` |
| **Paste Formula Results (Values)** | `⌘ + Shift + V` | `⌥ + ⇧ + ⌘ + V` | `⌘ + Shift + V` | `@$v` |
| **Paste without Formatting** | `⌘ + Shift + V` | `⌥ + ⇧ + ⌘ + V` | `⌘ + Shift + V` | `@$v` |
| **Strikethrough** | `⌘ + Shift + X` | `⌃ + ⇧ + ⌘ + -` | `⌘ + Shift + X` | `@$x` |
| **Subscript** | `⌘ + ,` | `⌃ + ⌘ + -` | `⌘ + ,` | `@,` |
| **Superscript** | `⌘ + .` | `⌃ + ⇧ + ⌘ + +` | `⌘ + .` | `@.` |
| **Insert Comment** | `⌥ + ⌘ + M` | `⇧ + ⌘ + K` | `⌥ + ⌘ + M` | `@~m` |

---

### C. Apple Keynote $\leftrightarrow$ Google Slides
| Function | Google Slides Shortcut | Apple Keynote Default | New Shortcut in Keynote | AppKit Key Code |
| :--- | :--- | :--- | :--- | :--- |
| **Align Center** | `⌘ + Shift + E` | `⌘ + \|` | `⌘ + Shift + E` | `@$e` |
| **Align Left** | `⌘ + Shift + L` | `⌘ + {` | `⌘ + Shift + L` | `@$l` |
| **Align Right** | `⌘ + Shift + R` | `⌘ + }` | `⌘ + Shift + R` | `@$r` |
| **Justify** | `⌘ + Shift + J` | `⌥ + ⌘ + \|` | `⌘ + Shift + J` | `@$j` |
| **Bring to Front** | `⌘ + Shift + ↑` | `⇧ + ⌘ + F` | `⌘ + Shift + ↑` | `@$\UF700` |
| **Send to Back** | `⌘ + Shift + ↓` | `⇧ + ⌘ + B` | `⌘ + Shift + ↓` | `@$\UF701` |
| **Bring Forward** | `⌘ + ↑` | `⌥ + ⇧ + ⌘ + F` | `⌘ + ↑` | `@\UF700` |
| **Send Backward** | `⌘ + ↓` | `⌥ + ⇧ + ⌘ + B` | `⌘ + ↓` | `@\UF701` |
| **Paste without Formatting** | `⌘ + Shift + V` | `⌥ + ⇧ + ⌘ + V` | `⌘ + Shift + V` | `@$v` |
| **Strikethrough** | `⌘ + Shift + X` | `⌃ + ⇧ + ⌘ + -` | `⌘ + Shift + X` | `@$x` |
| **Insert Comment** | `⌥ + ⌘ + M` | `⇧ + ⌘ + K` | `⌥ + ⌘ + M` | `@~m` |

---

## 2. Included Files

1. [apply_shortcuts.sh](file:///Users/bunnypro/google_iwork_shortcuts/apply_shortcuts.sh) — Bash script that applies the shortcuts to both `com.apple.*` and `com.apple.iWork.*` bundle domains and reloads `cfprefsd`.
2. [remove_shortcuts.sh](file:///Users/bunnypro/google_iwork_shortcuts/remove_shortcuts.sh) — Reverts all custom shortcuts back to Apple defaults.
3. [com.apple.Pages.plist](file:///Users/bunnypro/google_iwork_shortcuts/com.apple.Pages.plist) — Property list for Pages.
4. [com.apple.Numbers.plist](file:///Users/bunnypro/google_iwork_shortcuts/com.apple.Numbers.plist) — Property list for Numbers.
5. [com.apple.Keynote.plist](file:///Users/bunnypro/google_iwork_shortcuts/com.apple.Keynote.plist) — Property list for Keynote.

---

## 3. How to Use

### Run via Terminal:
```bash
cd /Users/bunnypro/google_iwork_shortcuts
./apply_shortcuts.sh
```

### To Revert Back to Apple Defaults:
```bash
cd /Users/bunnypro/google_iwork_shortcuts
./remove_shortcuts.sh
```

*Note: If Pages, Numbers, or Keynote are open, restart them for the changes to take effect.*
