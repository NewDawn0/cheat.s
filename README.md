# ⚡ cheat.s – fast cheats for slow brains

> A zero-fat, lightning-fast CLI cheat tool written in 100% hand-rolled pure masochist-grade x64 Assembly.

> No garbage collector. No runtime. No excuses.

---

## 🍿 Trying it out

Create a temporary nix shell

```bash
nix shell github:NewDawn0/cheat.s
```

## ⚙️ How To Build

### 🧊 The Nix Way (reproducible & respectable)

```bash
nix build
```

Minimal. Deterministic. Unapologetically lean.

---

### 🛠️ The GNU Way (Make & Autoconf)

> For when you want your build system to feel like an archaeology dig.

```bash
autoconf -i
./configure
make patch
make build
```

Requires:

- `nasm` – to write code no one else wants to read
- `cc` – to make it something your OS will tolerate
- `make` – because you're not doing this by hand
- `autoconf` – for ancient ritual reasons

---

## 🚀 How To Use

```bash
./cheat [topic]
```

### Available Topics:

- `ansi` – Color codes that make your terminal sparkle ✨
- `months` – How many days hath September again?
- `alphabet` – Because LMNOP is a lie we tell children
- `help` – Or no arg at all, and you’ll get a helpful (and colorful) guide

Example:

```bash
./cheat ansi
```

💥 Output in color. Instant. Less RAM than a Slack emoji.

---

## 🧨 Why Assembly?

**_Because sometimes you just want to print a cheat sheet and_**:

- **Rust** makes you write a novel just to get past the borrow checker
- **Python** guzzles 300MB of RAM to tell you what month it is — and still prints `None` when you forget a return
- **Java Script** installs 18,000 packages and 42 CVEs just to color “Hello, World”
- **C** says “sure, go ahead” — then gives you 99 undefined behaviors

Meanwhile:

`cheat.s` starts in nanoseconds, prints in microseconds, and dies like a legend.

No guardrails. No guilt. Just minimalism

> It’s written in assembly because I wanted to suffer — and now so can **you.**

---

## 🤝 Contributing

Want to add a cheat topic?

- Fork it
- Write it in `src/<module>.asm` using [NASM syntax](https://www.nasm.us/docs.php)
- Send the PR, and bring a fire extinguisher

If your commit includes a new syscall or a comment like `; this is evil but it works`, it’ll probably get merged on principle.

---

## 📜 License

MIT – because even the most dangerous ideas deserve freedom.

---

## 🔥 Final Thoughts

> `cheat.s` – For when your memory leaks more than your code.

💾 Save bytes. Burn cycles. **Embrace the suffering.**
