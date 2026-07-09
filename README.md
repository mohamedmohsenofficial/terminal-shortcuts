# Terminal Shortcuts

A lightweight collection of one-word terminal commands for **Linux**, **macOS**, and **Windows**.

Run common system tasks using memorable commands instead of long command sequences.

```bash
update
```

or

```bash
cleaner
```

Every command is an independent shell script or PowerShell script that automates one or more terminal tasks.

---

# Features

- One-word commands
- Linux support
- macOS support
- Windows support
- One-command installation
- Lightweight
- Easy customization
- Automatic command discovery
- Open Source

---

# Compatibility

- Windows 10
- Windows 11
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

The goal of this project is to provide clean, memorable shortcuts that simplify everyday terminal usage across different operating systems while keeping everything lightweight and easy to maintain.

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

## Windows

Run **PowerShell as Administrator**:

```powershell
irm https://raw.githubusercontent.com/mohamedmohsenofficial/terminal-shortcuts/main/install/install-windows.ps1 | iex
```

Each installer automatically:

- Downloads the latest version
- Installs every available command
- Makes commands executable (Linux/macOS)
- Creates symbolic links or PowerShell wrappers
- Adds the installation directory to your PATH (if needed)

---

# Manual Installation

## Linux / macOS

Copy the command you want into `~/.local/bin`:

```bash
cp commands/linux/update ~/.local/bin/update
chmod +x ~/.local/bin/update
```

Run it:

```bash
update
```

## Windows

Copy any PowerShell command from:

```text
commands/windows/
```

to a directory included in your `PATH`, or simply use the installer.

Example:

```powershell
update
```

---

# Updating

## Automatic Updates

Terminal Shortcuts automatically checks for updates every time you run any command.

If a newer version is available on GitHub, it is downloaded and installed automatically before the command continues.

This process runs silently in the background and does **not** interrupt your workflow.

Example:

```text
$ update

Running some updates to keep Terminal Shortcuts healthy... 😚

Windows Master Updater & Cleaner
...
```

OR

## Run the installer again.

## Linux

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/mohamedmohsenofficial/terminal-shortcuts/main/install/install-linux.sh)
```

## macOS

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/mohamedmohsenofficial/terminal-shortcuts/main/install/install-macos.sh)
```

## Windows

```powershell
irm https://raw.githubusercontent.com/mohamedmohsenofficial/terminal-shortcuts/main/install/install-windows.ps1 | iex
```

---

# Uninstall

## Linux / macOS

```bash
bash ~/.terminal-shortcuts/install/uninstall.sh
```

## Windows

```powershell
powershell -ExecutionPolicy Bypass -File uninstall-windows.ps1
```

---

# Usage

Linux / macOS:

```bash
update
cleaner
repair
```

Windows PowerShell:

```powershell
update
cleaner
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
│   │   ├── update
│   │   ├── cleaner
│   │   ├── repair
│   │   ├── check_os
│   │   └── ...
│   │
│   ├── macos/
│   │   ├── update
│   │   ├── cleaner
│   │   ├── repair
│   │   └── ...
│   │
│   └── windows/
│       ├── update.ps1
│       ├── cleaner.ps1
│       ├── repair.ps1
│       └── ...
│
├── install/
│   ├── install-linux.sh
│   ├── install-macos.sh
│   ├── install-windows.ps1
│   ├── update-terminal-shortcuts.sh
│   ├── update-terminal-shortcuts.ps1
│   ├── uninstall.sh
│   └── uninstall-windows.ps1
│
├── version
├── README.md
├── LICENSE
└── .gitignore
```

---

# Creating a New Command

1. Create a new command inside one of these directories:

```text
commands/linux/
commands/macos/
commands/windows/
```

2. Add your shell or PowerShell commands.

3. Make it executable if required.

Linux / macOS:

```bash
chmod +x your-command
```

Windows:

Save the command as a `.ps1` file.

4. Run the installer again.

The installer automatically installs every new command available for your operating system.

---

# Contributing

Contributions of all sizes are always welcome.

The goal of this project is simple:

Make the terminal easier, more approachable, and less intimidating for everyone.

Whether you're an experienced developer or someone writing their very first script, your contribution matters.

You can help by:

- Add new commands
- Improve existing commands
- Fix bugs
- Improve documentation
- Support additional Linux distributions
- Improve macOS compatibility
- Expand Windows support
- Suggest new ideas

This project is built around the spirit of open source.

We believe software should be open, accessible, and easy to understand.

If this project helps even one new Linux user feel more comfortable using the terminal, then it has achieved its purpose.

Everyone is welcome here.

Open an Issue, submit a Pull Request, or simply share your ideas.

---

# Community

Terminal Shortcuts is more than a collection of scripts.

It is an open-source community effort to make everyday terminal tasks simpler and more accessible.

Many people are interested in Linux and open-source software but are discouraged by long commands and a steep learning curve.

This project aims to remove that barrier by replacing complex command sequences with simple, memorable commands.

Every contribution—whether it's code, documentation, bug reports, testing, translations, or ideas—helps make the terminal friendlier for newcomers while remaining useful for experienced users.

Together, we can make open-source software easier to learn, easier to use, and easier to share.

---

# Roadmap

- More built-in commands
- Interactive installer
- Automatic self-update
- Command auto-completion
- Configuration file
- Package manager detection
- Better documentation
- More Windows commands
- More macOS commands
- More Linux distributions

---

# License

Licensed under the MIT License.

See the `LICENSE` file for details.

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

Built with passion for developers, Linux users, Windows users, macOS users, terminal enthusiasts, and everyone who believes in open source, software freedom, and the joy of learning, building, and sharing.
