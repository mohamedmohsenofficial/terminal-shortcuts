
# Terminal Shortcuts

A lightweight collection of one-word terminal commands for **Linux** and **macOS**.

Run common system tasks using memorable commands instead of long command sequences.

```bash
update
```

or

```bash
cleaner
```

Every command is an independent shell script that automates one or more terminal tasks.

---

# Features

- One-word commands
- Linux support
- macOS support
- One-command installation
- Lightweight
- Easy customization
- Automatic command discovery
- Open Source

---

# Compatibility

- Fedora
- Ubuntu
- Debian
- Arch Linux
- Linux Mint
- macOS

---

# Why?

Many terminal tasks require running multiple commands.

Instead of remembering long command sequences, simply type a single command such as:

```bash
update
```

The goal of this project is to provide clean, memorable shortcuts that simplify everyday terminal usage.

---

# Installation

## Linux

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/mohamedmohsenofficial/terminal-shortcuts/main/install/install-linux.sh)
```

## macOS

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/mohamedmohsenofficial/terminal-shortcuts/main/install/install-macos.sh)
```

The installer automatically:

- Downloads the latest version
- Installs every available command
- Makes commands executable
- Creates symbolic links
- Adds `~/.local/bin` to your PATH (if needed)

---

# Manual Installation

Copy the command you want into `~/.local/bin`:

```bash
cp commands/linux/update ~/.local/bin/update
chmod +x ~/.local/bin/update
```

Run it:

```bash
update
```

---

# Updating

Run the installer again.

Linux:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/mohamedmohsenofficial/terminal-shortcuts/main/install/install-linux.sh)
```

macOS:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/mohamedmohsenofficial/terminal-shortcuts/main/install/install-macos.sh)
```

---

# Uninstall

```bash
bash ~/.terminal-shortcuts/install/uninstall.sh
```

---

# Usage

```bash
update
cleaner
repair
```

Example:

Instead of:

```bash
sudo dnf upgrade --refresh
sudo flatpak update
sudo dnf autoremove
sudo dnf clean all
```

Run:

```bash
update
```

---

# Project Structure

```text
terminal-shortcuts/
├── commands/
│   ├── linux/
│   └── macos/
├── install/
│   ├── install-linux.sh
│   ├── install-macos.sh
│   └── uninstall.sh
├── README.md
└── LICENSE
```

---

# Creating a New Command

1. Create a new executable file inside:

```text
commands/linux/
```

or

```text
commands/macos/
```

2. Add your shell commands.
3. Make it executable:

```bash
chmod +x your-command
```

4. Run the installer again.

The installer automatically installs every new command.

---

# Contributing

Contributions are welcome.

You can:

- Add a new command
- Improve an existing command
- Fix bugs
- Improve documentation
- Support more Linux distributions
- Improve macOS compatibility
- Suggest new ideas

Open an Issue or submit a Pull Request.

---

# Roadmap

- More built-in commands
- Interactive installer
- Automatic self-update
- Command auto-completion
- Configuration file
- Package manager detection
- Better documentation

---

# License

Licensed under the MIT License.

See the `LICENSE` file for details.

---

# Support

If you find this project useful, consider supporting it.

<p align="left">
  <a href="https://www.buymeacoffee.com/mohsenofficial" target="_blank">
    <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me a Coffee" width="200">
  </a>
</p>

---

# Acknowledgements

Inspired by the Unix philosophy:

> Do one thing and do it well.

Thanks to the open-source community for the tools and ideas that made this project possible.

---

Made with ❤️ for the open-source community.
