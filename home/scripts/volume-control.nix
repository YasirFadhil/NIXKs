{ pkgs }:

pkgs.writeShellScriptBin "volume-control" ''
  #!/bin/sh

  ACTION="$1"
  VOLUME_STEP="''${2:-5}"

  # Get current volume from noctalia-shell
  get_volume() {
    noctalia-shell ipc call volume getVolume 2>/dev/null | grep -o '[0-9]\+' | head -1
  }

  # Get mute status from noctalia-shell
  get_mute_status() {
    noctalia-shell ipc call volume getMuteStatus 2>/dev/null | grep -q "muted" && echo "muted" || echo "unmuted"
  }

  # Show notification
  show_notification() {
    local volume=$1
    local status=$2

    if [ "$status" = "muted" ]; then
      ${pkgs.libnotify}/bin/notify-send -u low -t 1000 "Volume: $volume% (Muted)" -h int:value:$volume
    else
      ${pkgs.libnotify}/bin/notify-send -u low -t 1000 "Volume: $volume%" -h int:value:$volume
    fi
  }

  case "$ACTION" in
    increase|raise)
      noctalia-shell ipc call volume raise
      volume=$(get_volume)
      status=$(get_mute_status)
      show_notification "$volume" "$status"
      ;;
    decrease|lower)
      noctalia-shell ipc call volume decrease
      volume=$(get_volume)
      status=$(get_mute_status)
      show_notification "$volume" "$status"
      ;;
    toggle|mute)
      noctalia-shell ipc call volume muteOutput
      volume=$(get_volume)
      status=$(get_mute_status)
      show_notification "$volume" "$status"
      ;;
    get)
      get_volume
      ;;
    *)
      echo "Usage: volume-control {increase|decrease|toggle|get}"
      echo "  increase/raise - raise volume"
      echo "  decrease/lower - lower volume"
      echo "  toggle/mute    - toggle mute"
      echo "  get            - get current volume"
      exit 1
      ;;
  esac
''
