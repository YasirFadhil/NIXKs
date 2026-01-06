{ config, pkgs, lib, ... }:

{
  home.packages = [ pkgs.wlogout ];

  # Wlogout layout configuration
  home.file.".config/wlogout/layout".text = ''
    {
    "label" : "lock",
    "action" : "loginctl lock-session",
    "text" : "Lock",
    "keybind" : "l"
}
{
    "label" : "hibernate",
    "action" : "systemctl hibernate",
    "text" : "Hibernate",
    "keybind" : "h"
}
{
    "label" : "logout",
    "action" : "loginctl terminate-user $USER",
    "text" : "Logout",
    "keybind" : "e"
}
{
    "label" : "shutdown",
    "action" : "systemctl poweroff",
    "text" : "Shutdown",
    "keybind" : "s"
}
{
    "label" : "suspend",
    "action" : "systemctl suspend",
    "text" : "Suspend",
    "keybind" : "u"
}
{
    "label" : "reboot",
    "action" : "systemctl reboot",
    "text" : "Reboot",
    "keybind" : "r"
}

  '';

  # CSS styling for wlogout
  home.file.".config/wlogout/style.css".text = ''
    * {
	background-image: none;
	box-shadow: none;
}

window {
	background-color: rgba(48, 52, 70, 0.90);
}

button {
	border-radius: 0;
	border-color: #babbf1;
	text-decoration-color: #c6d0f5;
	color: #c6d0f5;
	background-color: #292c3c;
	border-style: solid;
	border-width: 1px;
	background-repeat: no-repeat;
	background-position: center;
	background-size: 25%;
}

button:focus, button:active, button:hover {
	/* 20% Overlay 2, 80% mantle */
	background-color: rgb(63, 66, 85);
	outline-style: none;
}

#lock {
    background-image: url("/etc/nixos/home/programs/wlogout/icons/lock.svg");
}

#logout {
    background-image: url("/etc/nixos/home/programs/wlogout/icons/logout.svg");
}

#suspend {
    background-image: url("/etc/nixos/home/programs/wlogout/icons/suspend.svg");
}

#hibernate {
    background-image: url("/etc/nixos/home/programs/wlogout/icons/hibernate.svg");
}

#shutdown {
    background-image: url("/etc/nixos/home/programs/wlogout/icons/shutdown.svg");
}

#reboot {
    background-image: url("/etc/nixos/home/programs/wlogout/icons/reboot.svg");
}
  '';
}
