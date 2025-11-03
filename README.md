# Homebrew Tap for ETC Software

This tap provides Homebrew casks for ETC lighting control software.

## Installation
```bash
brew tap spoiledsneeze/etc-eos
brew install --cask etc-eos-nomad
```

## Available Casks

- `etc-eos-nomad` - ETC Eos Family lighting control software (latest v3.x)
<!-- planned for future development
- `etc-eos-nomad@2.9` - Legacy version for XP-based consoles 
-->

## Updating

The casks include livecheck support to detect new versions:
```bash
brew livecheck --cask etc-eos-nomad
```

## Contributing

Pull requests welcome!
