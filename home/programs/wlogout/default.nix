{ config, pkgs, lib, ... }:

{
  home.packages = [ pkgs.wlogout ];

  # Wlogout layout configuration
  home.file.".config/wlogout/layout".text = ''
    {
    "label" : "lock",
    "action" : "loginctl lock-session",
    "text" : "",
    "keybind" : "l"
}
{
    "label" : "logout",
    "action" : "loginctl terminate-user $USER",
    "text" : "󰍃",
    "keybind" : "e"
}
{
    "label" : "poweroff",
    "action" : "systemctl poweroff",
    "text" : "󰐥",
    "keybind" : "s"
}
{
    "label" : "reboot",
    "action" : "systemctl reboot",
    "text" : "",
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
    font-family: "FiraCode Nerd Font";
    font-size: 40px;
}

#logout {
    font-family: "FiraCode Nerd Font";
    font-size: 40px;
}

#poweroff {
    font-family: "FiraCode Nerd Font";
    font-size: 40px;
}

#reboot {
    font-family: "FiraCode Nerd Font";
    font-size: 40px;
}
  '';
}
