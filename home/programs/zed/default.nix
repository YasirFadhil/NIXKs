{ pkgs, ... }:

{
  # Zed settings
  home.file.".config/zed/settings.json".text = ''
    {
      "ui_font_family": "SF Pro Display",
      "buffer_font_family": "SF Mono",
      "icon_theme": "Material Icon Theme",
      "vim_mode": true,
      "agent": {
        "default_model": {
          "provider": "copilot_chat",
          "model": "claude-haiku-4.5"
        },
        "model_parameters": []
      },
      "ui_font_size": 16,
      "buffer_font_size": 15,
      "theme": {
        "mode": "system",
        "light": "One Light",
        "dark": "One Dark Pro Max"
      }
    }
  #   {
  #     "icon_theme": "Material Icon Theme",
  #     "ui_font_size": 16,
  #     "buffer_font_size": 15,
  #     "vim_mode": true,
  #     "theme": {
  #       "mode": "dark",
  #       "light": "One Light",
  #       "dark": "One Dark Pro Max"
  #     },
  #     "languages": {
  #       "Python": {
  #         "language_servers": ["pylsp"],
  #         "formatter": {
  #           "external": {
  #             "command": "black",
  #             "arguments": ["-"]
  #           }
  #         }
  #       }
  #     }
  #   }
  '';

  # Keymap configuration
  home.file.".config/zed/keymap.json".text = ''
    [
      {
        "context": "Workspace",
        "bindings": {
          "ctrl-shift-a": "editor::SelectAll"
        }
      },
      {
        "context": "Editor",
        "bindings": {
          "ctrl-shift-v": "editor::Paste",
          "ctrl-shift-a": "editor::SelectAll"
        }
      },
      {
        "context": "Editor && vim_mode == insert",
        "bindings": {
        }
      }
    ]
  '';
}
