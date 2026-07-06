# Terminal Shortcuts

A collection of simple one-word terminal commands for **Linux** and **macOS**.

Instead of remembering long command sequences, simply type a single command.

```bash
update
```

or

```bash
cleaner
```

Each command automates one or more terminal tasks to make your daily workflow faster, cleaner, and easier.

---

# Why?

Many terminal tasks require running multiple commands.

For example, updating a Linux system may involve package updates, Flatpak updates, firmware updates, cache cleanup, and many other maintenance commands.

Instead of remembering and typing every command manually, simply run:

```bash
update
```

The goal of this project is to provide clean, memorable one-word commands that simplify everyday terminal usage.

---

# Features

- 🚀 One-word commands
- 🐧 Linux support
- 🍎 macOS support
- ⚡ One-command installation
- 🔄 Easy updates
- 🔧 Easy customization
- 📦 Lightweight
- ❤️ Open Source

---

# Available Commands

| Command | Description |
|---------|-------------|
| `update` | Update and maintain your system. |
| `cleaner` | Remove cache and unused files. |
| `repair` | Repair common system issues. |
| `diskinfo` | Show disk usage. |
| `meminfo` | Show memory usage. |
| `cpuinfo` | Show CPU information. |
| `battery` | Display battery status. |
| `myip` | Show your public IP address. |
| `ipinfo` | Display network information. |
| `flushdns` | Flush the DNS cache. |
| `services` | List running services. |
| `logs` | Show recent system logs. |
| `processes` | Show running processes. |
| `gitclean` | Remove merged Git branches. |
| `dockerclean` | Remove unused Docker resources. |
| `dockerupdate` | Update Docker containers. |
| `speedtest` | Run an internet speed test. |
| `backup` | Create a backup. |
| `restore` | Restore a backup. |
| `shutdownnow` | Shut down the computer immediately. |
| `rebootnow` | Restart the computer immediately. |

More commands will be added over time.

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

- Downloads the latest version of Terminal Shortcuts
- Installs all available commands
- Makes every command executable
- Creates the required symbolic links
- Adds the commands to your PATH (if needed)

No cloning.

No manual setup.

Just one command.

---

# Updating

To install the latest version, simply run the installer again.

## Linux

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/mohamedmohsenofficial/terminal-shortcuts/main/install/install-linux.sh)
```

## macOS

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/mohamedmohsenofficial/terminal-shortcuts/main/install/install-macos.sh)
```

---

# Uninstall

Linux & macOS

```bash
bash ~/.terminal-shortcuts/install/uninstall.sh
```

This removes:

- Installed commands
- Symbolic links
- Terminal Shortcuts installation directory

---

# Usage

After installation, simply type the command you want.

```bash
update
```

```bash
cleaner
```

```bash
repair
```

No aliases.

No long command sequences.

Just one word.

---

# Project Structure

```text
terminal-shortcuts/
│
├── commands/
│   ├── linux/
│   │   ├── update
│   │   ├── cleaner
│   │   ├── repair
│   │   └── ...
│   │
│   └── macos/
│       ├── update
│       ├── cleaner
│       ├── repair
│       └── ...
│
├── install/
│   ├── install-linux.sh
│   ├── install-macos.sh
│   └── uninstall.sh
│
├── README.md
└── LICENSE
```

---

# Customization

Every command is an independent shell script.

You can edit existing commands or create your own to fit your workflow.

---

# Contributing

Contributions are welcome.

If you'd like to improve Terminal Shortcuts:

1. Fork the repository.
2. Create a new branch.
3. Make your changes.
4. Open a Pull Request.

Bug reports, feature requests, and suggestions are always appreciated.

---

# Roadmap

Planned improvements:

- More built-in commands
- Support for additional Linux distributions
- Interactive installer
- Automatic updates
- Better documentation
- Command categories
- Optional command selection during installation

---

# License

This project is licensed under the MIT License.

See the `LICENSE` file for more information.

---

## 💖 Support

If you find this project useful, consider supporting its development.

Every contribution helps improve features, maintain the project, and keep it free for everyone.

<p align="left">
  <a href="https://www.buymeacoffee.com/mohsenofficial" target="_blank">
    <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me a Coffee" width="200">
  </a>
</p>

---

Built for my own workflow and shared with the open-source community.

If it makes your terminal experience a little faster, cleaner, or easier, then it has achieved its purpose.

Made with ❤️ for people who love the terminal.
