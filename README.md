<div align="center">

```
 ╔══════════════════════════════════════════════════════════════╗
    ▓▒░  ≡≡≡   D I R B A N N E R   ·   ATDT YOUR FILESYSTEM   ≡≡≡  ░▒▓

   ██████   ██  ██████      🦊  per-directory ANSI banners
   ██   ██  ██  ██   ██         pure BBS nostalgia for your terminal
   ██   ██  ██  ██████
   ██   ██  ██  ██   ██     "Every directory deserves an entrance."
   ██████   ██  ██   ██
 ╚══════════════════════════════════════════════════════════════╝   NO CARRIER
```

**Your terminal, like it's 1992.** Drop a `.dirbanner` file in any directory and
it lights up the moment you `cd` in ~ block letters, double-line frames, and that
saturated CRT glow you forgot you missed.

</div>

---

## ☎️ The vibe

Remember dialing into a board at 2400 baud and watching the ANSI welcome screen
paint itself line by line? The cyan frames, the magenta titles, the `▓▒░` gradient
bars, the cheerful `NO CARRIER` when it all fell over?

`dirbanner` brings that back ~ except now the "board" is whatever directory you
just walked into. A project announces itself. A `~/work` folder reminds you of the
rules. A job-search folder whispers *the door is the deliverable.* The Upside Down,
but for your filesystem, and friendlier.

No daemon. No framework. One tiny shell function and a plain text file per
directory. That's the whole trick.

---

## 🚀 Install

```sh
git clone https://github.com/paullaudeman/dirbanner.git
cd dirbanner
./install.sh
```

The installer adds one sourcing line to your `~/.zshrc` (or `~/.bashrc`), wrapped
in markers so it's safe to re-run. Open a new shell and you're live.

Prefer to do it by hand? Add this to your rc file:

```sh
source /path/to/dirbanner/dirbanner.sh
```

Works on **zsh** (via `chpwd`) and **bash** (via `PROMPT_COMMAND`).

---

## 🎛️ Usage

### Generate one

From inside any directory:

```sh
/path/to/dirbanner/new-banner "MY PROJECT" "what it is" "the spine line"
```

It scaffolds a colorized `.dirbanner` ~ frame, dial-up header, title, placeholder
bullets, and a `NO CARRIER` footer. Edit it to taste. If you have
[`figlet`](http://www.figlet.org/) installed, the title renders as full block
letters and gets tinted cyan automatically.

### Or write your own

A `.dirbanner` is just a text file that gets `cat`'d. Put raw ANSI escape codes in
it and they render. The catch: the codes must be **real ESC bytes** (`0x1b`), not
the literal text `\033`. Generate it with `printf`:

```sh
ESC=$(printf '\033')
CY="${ESC}[1;36m"; R="${ESC}[0m"
printf '%s\n' "   ${CY}hello from $(basename "$PWD")${R}" > .dirbanner
```

cd out, cd back, and there it is.

---

## 🎨 The palette

Bright/bold ANSI ~ the classic 16-color BBS look:

| Color | Code | Used for |
|-------|------|----------|
| cyan | `1;36` | titles, structure |
| magenta | `1;35` | frames, the spine line |
| green | `1;32` | bullets, the `go →` command |
| yellow | `1;33` | labels, link markers |
| white | `1;37` | identity text |
| red | `1;31` | warnings, `NO CARRIER` |
| dim grey | `1;30` | secondary detail |

> One opinionated default: **no bright blue (`94`).** It reads harsh on dark
> terminals. Everything else is fair game ~ go loud.

Always reset (`${ESC}[0m`) at the end of each colored span or the color bleeds
into the next line.

---

## 🧱 How it works

```
cd  →  shell fires a directory-change hook  →  hook cats ./.dirbanner if present
```

- **zsh** uses the built-in `chpwd` hook.
- **bash** emulates it through `PROMPT_COMMAND`, firing only when `$PWD` actually
  changes.

The hook only reads the **current** directory ~ no recursion, by design. Each
directory carries its own banner, or none. Frame rules go on top and bottom only;
no right-side rails, because emoji render at variable width and would break the
alignment.

---

## 📺 Examples

Peek at the `examples/` directory:

```sh
cat examples/dev.dirbanner
cat examples/project.dirbanner
```

(They're pre-rendered with real escape bytes, so `cat` shows them in full color.)

---

## 🤔 FAQ

**Should I commit `.dirbanner` to my repos?**
Your call. Commit it and it travels with the project (nice onboarding for the next
person). Or gitignore it and keep it machine-local. The `examples/` here are
committed on purpose.

**Will this slow down my shell?**
No. It's a single `[ -r .dirbanner ]` test per directory change. If the file isn't
there, nothing happens.

**My banner looks washed out.**
That's your terminal's ANSI palette, not the file. Use a profile with a proper
16-color scheme and the glow comes back.

---

## 📟 License

MIT. Go make your terminal flashy.

```
 ░▒▓ thanks for dialing in ▓▒░
```
