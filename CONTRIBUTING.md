# Contributing to Blog-App

Thank you for your interest in contributing to Blog-App! We welcome contributions from everyone. This document provides guidelines and instructions for contributing to our project.

## Code of Conduct

Please be respectful and considerate in all interactions with other contributors and maintainers. We are committed to providing a welcoming and inclusive environment for all.

## Getting Started

### Prerequisites

- Ruby (check the Gemfile for the required version)
- Node.js and npm (for JavaScript dependencies)
- A basic understanding of Rails, HTML, CSS, and Ruby

### Setting Up Your Development Environment

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/your-username/Blog-App.git
   cd Blog-App
   ```
3. **Add the upstream remote**:
   ```bash
   git remote add upstream https://github.com/sohamchavan07/Blog-App.git
   ```
4. **Install dependencies**:
   ```bash
   bundle install
   ```
5. **Set up the database**:
   ```bash
   rails db:create
   rails db:migrate
   ```
6. **Start the development server**:
   ```bash
   rails server
   ```

## Development Workflow

### Creating a Branch

1. **Update your local repository**:
   ```bash
   git checkout main
   git pull upstream main
   ```

2. **Create a new branch** for your feature or fix:
   ```bash
   git checkout -b feature/your-feature-name
   ```
   or
   ```bash
   git checkout -b fix/your-bug-fix
   ```

### Making Changes

- Follow the existing code style and conventions
- Keep commits atomic and write clear commit messages
- Add tests for new features or bug fixes
- Ensure all tests pass before pushing:
  ```bash
  rails test
  ```

### Code Style Guidelines

- **Ruby**: Follow Rails conventions and use 2-space indentation
- **HTML/CSS**: Keep markup semantic and styles organized
- **JavaScript**: Use consistent formatting and clear variable names
- **Comments**: Add comments for complex logic or non-obvious code

## Submitting Changes

### Push Your Branch

```bash
git push origin feature/your-feature-name
```

### Create a Pull Request

1. Go to your fork on GitHub
2. Click the "New Pull Request" button
3. Select your branch and provide a clear description of your changes
4. Include:
   - A descriptive title
   - A summary of the changes
   - Any related issue numbers (e.g., "Fixes #123")
   - Screenshots for UI changes (if applicable)

### Pull Request Guidelines

- Keep pull requests focused on a single feature or fix
- Ensure your branch is up to date with the main branch:
  ```bash
  git pull upstream main
  ```
- Respond to feedback and review comments promptly
- Keep the conversation professional and constructive

## Testing

- Write tests for new features using Rails' testing framework
- Ensure all existing tests continue to pass
- Run tests before submitting your pull request:
  ```bash
  rails test
  ```

## Reporting Issues

If you find a bug or have a feature suggestion:

1. Check if the issue already exists
2. Provide a clear description of the problem or suggestion
3. Include steps to reproduce (for bugs)
4. Add relevant screenshots or error messages (if applicable)
5. Mention your environment (OS, Ruby version, Rails version, etc.)

## Questions?

Feel free to:
- Open an issue for questions
- Check existing issues and discussions
- Contact the maintainers

## License

By contributing to Blog-App, you agree that your contributions will be licensed under the same license as the project.

---

Happy contributing! 🚀
