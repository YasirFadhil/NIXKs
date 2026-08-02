{ config, pkgs, ... }:

{
  # programs.rofi = {
  #   enable = true;
  #   package = pkgs.rofi;
  #   terminal = "ghostty";
  # };

  # Main rofi config with styling
  home.file.".config/rofi/config.rasi".text = ''
    configuration {
        modi: "drun,run";
        show-icons: true;
        icon-theme: "MacTahoe-dark";
        display-drun: " ";
        display-run: " ";
        drun-display-format: "{name}";
        disable-history: false;
        hide-scrollbar: true;
        sidebar-mode: false;
        terminal: "ghostty";
        font: "Sf Mono 11";
    }

    * {
        background: rgba(0, 0, 0, 0);
        foreground: rgba(255, 255, 255, 0.97);
        selected: rgba(255, 255, 255, 0.10);
        active: rgba(255, 255, 255, 0.10);
        urgent: rgba(255, 85, 85, 0.67);
        border-colour: rgba(255, 255, 255, 0.10);
        separatorcolor: transparent;
        background-color: transparent;
        text-color: @foreground;
    }

    window {
        transparency: "real";
        location: center;
        anchor: center;
        fullscreen: false;
        width: 350px;
        border-radius: 10px;
        cursor: "default";
        background-color: rgba(20, 20, 20, 0.70);
        border: 1px solid;
        border-color: rgba(255, 255, 255, 0.10);
    }

    mainbox {
        enabled: true;
        spacing: 0px;
        margin: 0px;
        padding: 16px;
        background-color: transparent;
        children: [ "inputbar", "listview" ];
    }

    inputbar {
        enabled: true;
        spacing: 10px;
        margin: 0px 0px 12px 0px;
        padding: 10px 14px;
        border-radius: 8px;
        background-color: rgba(255, 255, 255, 0.10);
        border: 1px solid;
        border-color: rgba(255, 255, 255, 0.15);
        text-color: @foreground;
        children: [ "prompt", "entry" ];
    }

    prompt {
        enabled: true;
        background-color: transparent;
        text-color: inherit;
    }

    entry {
        enabled: true;
        background-color: transparent;
        text-color: inherit;
        cursor: text;
        placeholder: "Search...";
        placeholder-color: rgba(255, 255, 255, 0.50);
    }

    listview {
        enabled: true;
        columns: 1;
        lines: 5;
        cycle: true;
        dynamic: true;
        scrollbar: false;
        layout: vertical;
        reverse: false;
        fixed-height: true;
        fixed-columns: true;
        spacing: 3px;
        background-color: transparent;
        text-color: @foreground;
        cursor: "default";
    }

    element {
        enabled: true;
        spacing: 10px;
        margin: 0px;
        padding: 8px 10px;
        border-radius: 6px;
        background-color: transparent;
        text-color: @foreground;
        cursor: pointer;
    }

    element normal.normal {
        background-color: transparent;
        text-color: @foreground;
    }

    element selected.normal {
        background-color: rgba(255, 255, 255, 0.15);
        text-color: @foreground;
    }

    element alternate.normal {
        background-color: transparent;
        text-color: @foreground;
    }

    element-icon {
        background-color: transparent;
        text-color: inherit;
        size: 28px;
        cursor: inherit;
    }

    element-text {
        background-color: transparent;
        text-color: inherit;
        highlight: bold;
        cursor: inherit;
        vertical-align: 0.5;
        horizontal-align: 0.0;
    }
  '';

  # Emoji theme
  home.file.".config/rofi/custom-rofi/config-emoji.rasi".text = ''
    * {
        background: rgba(0, 0, 0, 0);
        foreground: rgba(255, 255, 255, 0.97);
        selected: rgba(255, 255, 255, 0.10);
        border-colour: rgba(255, 255, 255, 0.10);
        separatorcolor: transparent;
        text-color: @foreground;
    }

    window {
        transparency: "real";
        location: center;
        anchor: center;
        width: 500px;
        border-radius: 10px;
        background-color: rgba(20, 20, 20, 0.70);
        border: 1px solid;
        border-color: rgba(255, 255, 255, 0.10);
    }

    mainbox {
        spacing: 0px;
        padding: 16px;
        background-color: transparent;
        children: [ "inputbar", "listview" ];
    }

    inputbar {
        spacing: 10px;
        margin: 0px 0px 12px 0px;
        padding: 10px 14px;
        border-radius: 8px;
        background-color: rgba(255, 255, 255, 0.10);
        border: 1px solid;
        border-color: rgba(255, 255, 255, 0.15);
        children: [ "prompt", "entry" ];
    }

    prompt {
        background-color: transparent;
        text-color: inherit;
    }

    entry {
        background-color: transparent;
        text-color: inherit;
        cursor: text;
        placeholder: "Search emoji...";
        placeholder-color: rgba(255, 255, 255, 0.50);
    }

    listview {
        columns: 5;
        lines: 6;
        spacing: 5px;
        background-color: transparent;
    }

    element {
        spacing: 10px;
        padding: 8px;
        border-radius: 4px;
        background-color: rgba(255, 255, 255, 0.05);
        text-color: @foreground;
    }

    element normal.normal {
        background-color: rgba(255, 255, 255, 0.05);
        text-color: @foreground;
    }

    element selected.normal {
        background-color: rgba(255, 255, 255, 0.15);
        text-color: @foreground;
    }

    element alternate.normal {
        background-color: rgba(255, 255, 255, 0.05);
        text-color: @foreground;
    }

    element-text {
        horizontal-align: 0.5;
        vertical-align: 0.5;
        background-color: transparent;
        text-color: inherit;
    }

    element-icon {
        size: 0px;
    }
  '';

  # Clipboard theme
  home.file.".config/rofi/custom-rofi/config-clipboard.rasi".text = ''
    * {
        background: rgba(0, 0, 0, 0);
        foreground: rgba(255, 255, 255, 0.97);
        selected: rgba(255, 255, 255, 0.10);
        border-colour: rgba(255, 255, 255, 0.10);
        separatorcolor: transparent;
        text-color: @foreground;
    }

    window {
        transparency: "real";
        location: center;
        anchor: center;
        width: 400px;
        border-radius: 10px;
        background-color: rgba(20, 20, 20, 0.70);
        border: 1px solid;
        border-color: rgba(255, 255, 255, 0.10);
    }

    mainbox {
        spacing: 0px;
        padding: 16px;
        background-color: transparent;
        children: [ "inputbar", "listview" ];
    }

    inputbar {
        spacing: 10px;
        margin: 0px 0px 12px 0px;
        padding: 10px 14px;
        border-radius: 8px;
        background-color: rgba(255, 255, 255, 0.10);
        border: 1px solid;
        border-color: rgba(255, 255, 255, 0.15);
        children: [ "prompt", "entry" ];
    }

    prompt {
        background-color: transparent;
        text-color: inherit;
    }

    entry {
        background-color: transparent;
        text-color: inherit;
        cursor: text;
        placeholder: "Search clipboard...";
        placeholder-color: rgba(255, 255, 255, 0.50);
    }

    listview {
        columns: 1;
        lines: 10;
        spacing: 8px;
        background-color: transparent;
    }

    element {
        spacing: 10px;
        padding: 8px 12px;
        border-radius: 6px;
        background-color: rgba(255, 255, 255, 0.05);
        text-color: @foreground;
    }

    element normal.normal {
        background-color: rgba(255, 255, 255, 0.05);
        text-color: @foreground;
    }

    element selected.normal {
        background-color: rgba(255, 255, 255, 0.15);
        text-color: @foreground;
    }

    element alternate.normal {
        background-color: rgba(255, 255, 255, 0.05);
        text-color: @foreground;
    }

    element-text {
        background-color: transparent;
        text-color: inherit;
    }

    element-icon {
        size: 0px;
    }
  '';

  # Emoji picker script
  home.file.".local/bin/rofi-emoji".source = pkgs.writeShellScript "rofi-emoji" ''
    #!/bin/bash
    emoji_file="$HOME/.local/share/rofi/emojis.txt"
    mkdir -p "$(dirname "$emoji_file")"

    if [ ! -f "$emoji_file" ]; then
      cat > "$emoji_file" << 'EOF'
    😀 grinning
    😃 smiley
    😄 smile
    😁 beaming
    😆 laughing
    😅 sweat_smile
    🤣 rolling_on_floor
    😂 joy
    🙂 slightly_smiling
    🙃 upside_down
    😉 wink
    😊 blush
    😇 innocent
    🥰 heart_eyes
    😍 love
    🤩 star_struck
    😘 kissing_heart
    😗 kissing
    😚 kissing_closed_eyes
    😙 kissing_smiling
    🥲 slightly_smiling_mouth
    😋 yum
    😛 tongue
    😜 wink_tongue
    🤪 crazy
    😌 relieved
    😔 pensive
    😑 expressionless
    😐 neutral_face
    😏 smirk
    😒 unamused
    🙁 slightly_frowning
    ☹️ frowning
    😲 astonished
    😞 disappointed
    😖 confounded
    😢 cry
    😭 sob
    😤 triumph
    😠 angry
    🤬 cursing_face
    😈 smiling_imp
    👿 imp
    💔 broken_heart
    ❤️ red_heart
    🧡 orange_heart
    💛 yellow_heart
    💚 green_heart
    💙 blue_heart
    💜 purple_heart
    🤍 white_heart
    🤎 brown_heart
    🖤 black_heart
    EOF
    fi

    selected=$(cat "$emoji_file" | rofi -dmenu -p " Emoji: " -config "$HOME/.config/rofi/custom-rofi/config-emoji.rasi" | awk '{print $1}')
    if [ -n "$selected" ]; then
      echo -n "$selected" | wl-copy
      # notify-send "Emoji copied: $selected"
    fi
  '';

  # Clipboard script
  home.file.".local/bin/rofi-clipboard".source = pkgs.writeShellScript "rofi-clipboard" ''
    #!/bin/bash
    cliphist list | rofi -dmenu -p " Clipboard: " -config "$HOME/.config/rofi/custom-rofi/config-clipboard.rasi" | cliphist decode | wl-copy
    # notify-send "Clipboard pasted"
  '';

  # Make scripts executable
  home.activation.makeScriptsExecutable = config.lib.dag.entryAfter ["writeBoundary"] ''
    chmod +x $HOME/.local/bin/rofi-emoji $HOME/.local/bin/rofi-clipboard 2>/dev/null || true
  '';
}
