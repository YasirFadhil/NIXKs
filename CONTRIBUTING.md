# Contributing to NIXKs

Thank you for your interest in contributing to NIXKs! This document provides guidelines and instructions for contributing to this NixOS configuration project.

## Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Help others learn and grow
- Report issues professionally

## How to Contribute

### Reporting Issues

Found a bug or have a suggestion? Please open an issue with:

1. **Clear title** - Describe the problem concisely
2. **Description** - What happened and what you expected
3. **Steps to reproduce** - How to replicate the issue
4. **Environment** - NixOS version, hardware, desktop environment
5. **Screenshots** - If applicable, include visual evidence

Example:
```
Title: Hyprland fails to start after rebuild

Description:
After rebuilding with the latest configuration, Hyprland won't start.
Expected to see Hyprland desktop, but got blank screen.

Steps:
1. Run `sudo nixos-rebuild switch --flake .#nixos`
2. Log out and back in
3. Select Hyprland from display manager

Environment:
- NixOS 25.05
- x86_64-linux
- AMD GPU
```

### Suggesting Enhancements

Have an idea for improvement? Open an issue with:

1. **Use case** - Why would this be useful?
2. **Example** - How would it work?
3. **Alternatives** - Any other solutions considered?

### Submitting Pull Requests

1. **Fork the repository**
   ```bash
   git clone https://github.com/YasirFadhil/NIXKs.git
   cd NIXKs
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bugfix-name
   ```

3. **Make your changes**
   - Follow the project structure
   - Keep changes focused and minimal
   - Add comments for complex logic

4. **Test your changes**
   ```bash
   # Check configuration validity
   nix flake check
   
   # Test without applying
   sudo nixos-rebuild dry-build --flake .
   
   # Test home manager
   home-manager build --flake .
   ```

5. **Commit with clear messages**
   ```bash
   git commit -m "Add [feature/fix]: Brief description"
   ```

6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Open a Pull Request**
   - Reference any related issues
   - Describe what changed and why
   - Include testing steps
   - Be open to feedback

## Project Structure Guidelines

### Adding a New Program

When adding configuration for a new program:

1. **Create a directory** in `home/programs/`
   ```bash
   mkdir home/programs/myprogram
   ```

2. **Create `default.nix`** with:
   ```nix
   { config, pkgs, ... }:
   {
     # Enable the program
     programs.myprogram.enable = true;
     
     # Or add to packages
     home.packages = with pkgs; [ myprogram ];
     
     # Configure settings
     programs.myprogram.settings = {
       option1 = "value1";
       option2 = "value2";
     };
   }
   ```

3. **Create optional files**:
   - `configFile` - For complex configurations
   - `keybindings.nix` - For keyboard shortcuts
   - `theme.nix` - For appearance settings

4. **Import in `home/home.nix`**:
   ```nix
   imports = [
     ./programs/myprogram
     # ... other imports
   ];
   ```

5. **Document** the configuration in `docs/` if needed

### Adding System Packages

1. **Edit `nixos/environment.nix`**:
   ```nix
   environment.systemPackages = with pkgs; [
     # Existing packages...
     newpackage
   ];
   ```

2. **Add comment** explaining why it's needed system-wide

3. **Update** `docs/PACKAGE_ORGANIZATION.md` if adding a large package

### Creating a New Desktop Environment Config

1. **Create directory** in `home/systems/`
   ```bash
   mkdir home/systems/myde
   ```

2. **Create `default.nix`** with complete configuration

3. **Update `home/home.nix`** to conditionally import it:
   ```nix
   imports = [
     ./systems/myde
     # ... other imports
   ];
   ```

4. **Document** in README if it's a major addition

## Code Style Guidelines

### Nix Code

1. **Formatting**
   - Use 2-space indentation
   - Keep lines readable (80-100 characters)
   - Use meaningful variable names

   Good:
   ```nix
   programs.myprogram.settings = {
     enable = true;
     fontSize = 12;
     colorScheme = "dark";
   };
   ```

   Bad:
   ```nix
   programs.myprogram.settings = {e=true;fs=12;cs="dark";};
   ```

2. **Comments**
   - Explain the "why", not the "what"
   - Use `#` for single-line comments
   - Group related settings together

   Good:
   ```nix
   # Enable hardware acceleration for better performance
   hardware.opengl.enable = true;
   ```

   Bad:
   ```nix
   # Enable opengl
   hardware.opengl.enable = true;
   ```

3. **Organization**
   - Group settings by category
   - Keep imports alphabetically sorted
   - Use descriptive option names

### Documentation

1. **README sections**
   - Clear headings with emojis
   - Code examples with language specified
   - Links to official documentation

2. **Comments in code**
   - Explain complex logic
   - Note any workarounds or hacks
   - Include issue/PR references when applicable

3. **File documentation**
   - Add header comment explaining purpose
   - Document non-obvious configurations
   - Link to official documentation

## Testing Your Changes

### Before Submitting

1. **Syntax check**
   ```bash
   nix flake check
   ```

2. **Build test (system)**
   ```bash
   sudo nixos-rebuild dry-build --flake .#nixos
   ```

3. **Build test (home)**
   ```bash
   home-manager build --flake .#yasirfadhil@nixos
   ```

4. **Evaluate flake**
   ```bash
   nix eval --impure .#nixosConfigurations
   ```

### Testing on Your System

1. **Create a test branch**
   ```bash
   git checkout -b test/feature
   ```

2. **Apply your changes**
   ```bash
   sudo nixos-rebuild switch --flake .
   home-manager switch --flake .
   ```

3. **Verify functionality**
   - Check all changed components work
   - Test edge cases
   - Verify no regressions

4. **Rollback if needed**
   ```bash
   sudo nixos-rebuild switch --rollback
   home-manager switch --rollback
   ```

## Documentation Requirements

### For Bug Fixes

- Explain what the bug was
- How you fixed it
- Any related issues

### For New Features

- What problem does it solve?
- How to use the new feature
- Any configuration needed
- Update main README if major

### For Code Changes

- Why the change was needed
- Any breaking changes
- Migration path if needed

## Commit Message Guidelines

Use clear, descriptive commit messages:

```
[type]: Brief description

Optional longer explanation that explains:
- Why the change was made
- What problem it solves
- Any side effects

Fixes #123 (if related to an issue)
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `refactor`: Code restructuring
- `style`: Formatting/styling
- `chore`: Maintenance tasks

Examples:
```
feat: Add Spicetify configuration for Spotify theming

docs: Update GETTING_STARTED.md with new instructions

fix: Resolve Hyprland keybinding conflict

refactor: Reorganize home packages for clarity

style: Format nix files with proper indentation
```

## Review Process

### What Reviewers Look For

1. **Code Quality**
   - Does it follow project conventions?
   - Is it maintainable?
   - Are there obvious bugs?

2. **Testing**
   - Has it been tested?
   - Are there edge cases to consider?

3. **Documentation**
   - Is it documented well?
   - Are there examples?

4. **Scope**
   - Are changes focused?
   - No unrelated modifications?

### Responding to Feedback

- Acknowledge all comments
- Ask for clarification if needed
- Make requested changes
- Respond to each point
- Push updates as new commits

## Becoming a Maintainer

Regular contributors who demonstrate:
- Quality code
- Good judgment
- Respectful communication
- Understanding of project goals

...may be invited to become maintainers. This includes:
- Review and merge privileges
- Ownership of specific areas
- Help guiding the project

## Resources

### Learning Resources

- **NixOS Manual**: https://nixos.org/manual/nixos/
- **Home Manager Manual**: https://nix-community.github.io/home-manager/
- **Nix Flakes**: https://nixos.wiki/wiki/Flakes
- **Nix Pills**: https://nixos.org/guides/nix-pills/

### Tools

- **Nix formatter**: `nixpkgs-fmt`
- **Nix linter**: `nix-linter`
- **Flake check**: `nix flake check`

### Community

- **NixOS Discourse**: https://discourse.nixos.org/
- **Reddit**: https://www.reddit.com/r/NixOS/
- **GitHub Discussions**: Use for questions

## FAQ

**Q: Do I need to sign a CLA?**
A: No, but please ensure you own the code or have permission to contribute it.

**Q: How long does review take?**
A: Usually 1-3 days, but depends on complexity and maintainer availability.

**Q: Can I contribute if I'm new to Nix?**
A: Absolutely! This is a great way to learn. We're happy to help explain things.

**Q: What if my changes break something?**
A: No worries! We can work together to fix it. That's what testing is for.

**Q: How do I become a maintainer?**
A: Be an active, positive contributor. Maintainers will reach out when ready.

## Questions?

- Open a discussion on GitHub
- Ask on NixOS Discourse
- Email the maintainer
- Join NixOS communities

## License

By contributing to NIXKs, you agree that your contributions will be licensed under the project's LICENSE file (MIT).

---

Thank you for contributing to NIXKs! 🎉