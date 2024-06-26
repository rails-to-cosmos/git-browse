# git-browse

Browse current file on corresponding Git management website.

## Features

- Quickly navigate to the current file and line on Git management websites.
- Supports popular Git management platforms like GitHub and GitLab.

## Installation

### Using `use-package`

Add the following to your Emacs configuration:

```elisp
(use-package git-browse
  :ensure t
  :config
  (global-set-key (kbd "C-c g") 'git-browse-current-line))
```

### Manually

1. Clone the repository:

    ```bash
    git clone https://github.com/rails-to-cosmos/git-browse.git
    ```

2. Add the following to your Emacs configuration:

   ```elisp
   (add-to-list 'load-path "/path/to/git-browse")
   (require 'git-browse)
   (global-set-key (kbd "C-c g") 'git-browse-current-line)
   ```

## Usage

1. Open a file that is part of a Git repository in Emacs.
2. Move the cursor to the line you want to browse on the Git management website.
3. Run the command `git-browse-current-line` (default keybinding: `C-c g`).
4. Your default web browser will open the corresponding file and line on the Git management website.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request on GitHub.
