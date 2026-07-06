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

Every command automates one or more terminal tasks, making your daily workflow faster, cleaner, and easier.

---

# Why?

Many everyday terminal tasks require running multiple commands.

For example, maintaining your operating system may involve updating packages, cleaning caches, removing unused files, refreshing package indexes, updating firmware, and other maintenance tasks.

Instead of remembering and typing every command manually, simply run:

```bash
update
```

The goal of this project is to provide clean, memorable one-word commands that simplify everyday terminal usage while remaining easy to customize.

---

# Features

- One-word commands
- Linux support
- macOS support
- One-command installation
- Lightweight
- Easy customization
- Easy updates
- Open Source

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

# Manual Installation

If you prefer not to use the automatic installer, you can install any command manually.

Copy the command you want to a directory that exists in your PATH, then make it executable.

Example:

```bash
sudo cp commands/linux/<command> /usr/local/bin/<command>
sudo chmod +x /usr/local/bin/<command>
```

Replace `<command>` with the command you want to install.

For example:

```text
update
cleaner
repair
myip
speedtest
```

After copying the file, simply run the command from any terminal.

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
cleaner
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

You can edit existing commands, modify their behavior, or create completely new shortcuts that match your own workflow.

Adding a new command is as simple as placing a new executable file inside:

```text
commands/linux/
```

or

```text
commands/macos/
```

Running the installer again will automatically install every new command without modifying the installer itself.

---

# Contributing

Contributions are always welcome.

Whether you want to:

- Add a new shortcut
- Improve an existing command
- Fix a bug
- Improve the documentation
- Support another Linux distribution
- Improve macOS compatibility
- Suggest a new feature

Feel free to open an Issue or submit a Pull Request.

Every contribution, regardless of size, helps improve this project for everyone.

---

# Roadmap

Planned improvements include:

- More built-in commands
- Additional Linux distribution support
- Interactive installer
- Automatic self-update
- Better documentation
- Command categories
- Optional command selection during installation
- Command auto-completion
- Optional package manager detection
- Configuration file support

---

# License

This project is licensed under the MIT License.

See the `LICENSE` file for more information.

---

## Support

If you find this project useful, consider supporting its development.

Every contribution helps improve new features, maintain the project, and keep it free and open source for everyone.

<p align="left">
  <a href="https://www.buymeacoffee.com/mohsenofficial" target="_blank">
    <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me a Coffee" width="200">
  </a>
</p>

---

Built for my own workflow and shared with the open-source community.

If this project saves you time or simplifies your daily terminal workflow, then it has achieved its purpose.

Built with passion for developers, power users, and terminal enthusiasts.
