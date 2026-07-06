# Terminal Shortcuts

A collection of simple one-word terminal commands for **Linux** and **macOS**.

Instead of remembering and typing long commands every time, you can run a single command such as:

```bash
update
```

or

```bash
cleaner
```

Each shortcut runs one or more terminal commands to automate common tasks.

---

# Why?

Many terminal tasks require multiple commands.

For example, updating your system may involve:

```bash
sudo dnf upgrade --refresh
flatpak update
```

or

```bash
sudo apt update
sudo apt upgrade
```

Instead of remembering every command, you only need to type:

```bash
update
```

The goal of this project is to make everyday terminal usage faster, cleaner, and easier.

---

# Features

* 🚀 One-word commands
* 🐧 Linux support
* 🍎 macOS support
* 📦 Easy installation
* 🔧 Easy customization
* 📝 Well documented
* ❤️ Open source

---

# Available Commands

| Command        | Description                                  |
| -------------- | -------------------------------------------- |
| `update`       | Update system packages.                      |
| `cleaner`      | Remove cache and unused packages.            |
| `doctor`       | Check system health.                         |
| `repair`       | Repair package issues.                       |
| `diskinfo`     | Show disk usage information.                 |
| `meminfo`      | Show memory usage.                           |
| `cpuinfo`      | Show CPU information.                        |
| `battery`      | Show battery status.                         |
| `myip`         | Display your public IP address.              |
| `ipinfo`       | Show network information.                    |
| `flushdns`     | Clear the DNS cache.                         |
| `services`     | List running services.                       |
| `logs`         | Display recent system logs.                  |
| `processes`    | Show the most resource-intensive processes.  |
| `gitclean`     | Remove merged Git branches.                  |
| `dockerclean`  | Remove unused Docker resources.              |
| `dockerupdate` | Update Docker containers (where applicable). |
| `speedtest`    | Run an internet speed test.                  |
| `backup`       | Create a backup.                             |
| `restore`      | Restore a backup.                            |
| `shutdownnow`  | Shut down the computer immediately.          |
| `rebootnow`    | Restart the computer immediately.            |

More commands will be added over time.

---

# Installation

Clone the repository:

```bash
git clone https://github.com/mohamedmohsenofficial/terminal-shortcuts.git
```

Go to the project folder:

```bash
cd terminal-shortcuts
```

Run the installer for your operating system.

Linux:

```bash
./install/install-linux.sh
```

macOS:

```bash
./install/install-macos.sh
```

After installation, restart your terminal or reload your shell configuration.

---

# Usage

Once installed, simply type the command name.

Example:

```bash
update
```

or

```bash
cleaner
```

or

```bash
doctor
```

No need to remember long command sequences anymore.

---

# Project Structure

```
terminal-shortcuts/
│
├── commands/
├── install/
├── linux/
├── macos/
├── docs/
├── README.md
└── LICENSE
```

---

# Customization

Every shortcut is just a simple shell script.

You can modify any command or create your own shortcuts to match your workflow.

---

# Contributing

Contributions are welcome.

If you have an idea for a useful shortcut or want to improve an existing one:

1. Fork the repository.
2. Create a new branch.
3. Make your changes.
4. Open a Pull Request.

Bug reports, feature requests, and improvements are always appreciated.

---

# Roadmap

Planned improvements include:

* More built-in shortcuts
* Better cross-platform support
* Additional package managers
* Interactive installer
* Automatic updates
* Command categories
* Better documentation

---

# License

This project is licensed under the MIT License.

See the `LICENSE` file for more information.

---
## 💖 Support

If you find this project useful, consider supporting its development. Every contribution helps improve features, maintain the project, and keep it accessible for everyone. 🌍✨

<p align="left">
  <a href="https://www.buymeacoffee.com/mohsenofficial" target="_blank">
    <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me a Coffee" width="200">
  </a>
</p>

---


Built for my own needs, shared for the community. If it happens to help someone else, then it has done more than I originally intended

Built with passion, curiosity, countless hours of learning, and a deep love for open-source software.

Thank you for using this project and being part of its journey. 🤟🏼😘

Made with ❤️ for people who spend a lot of time in the terminal.
