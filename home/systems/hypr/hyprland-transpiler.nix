# Convert a classic Hyprland/Home Manager settings attrset into the Lua-shaped
# settings attrset expected by Home Manager's current configType = "lua" writer.
#
# Supported legacy entries in this first version:
#   monitor, env, exec-once, general/input/decoration/dwindle/master/scrolling/misc,
#   animations.enabled + bezier + animation, gesture, bind/bindm/bindl/bindel,
#   windowrule and layerrule.
#
# This is intentionally a Nix data transformer, not a text parser for arbitrary
# Hyprlang files. Unsupported bind dispatchers fail during evaluation so that
# they don't silently become broken Lua.
{ lib }:
let
  inline = lib.generators.mkLuaInline;
  toLua = value: lib.generators.toLua { } value;
  mkArgs = args: { _args = args; };
  trim = lib.strings.trim;
  splitComma = value: map trim (lib.splitString "," value);
  words = value: builtins.filter (word: word != "") (lib.splitString " " (trim value));
  has = builtins.hasAttr;
  optionalAttrs = lib.optionalAttrs;

  isNumber = value: builtins.match "-?[0-9]+(\\.[0-9]+)?" value != null;

  scalar = value:
    if value == "on" || value == "true" then true
    else if value == "off" || value == "false" then false
    else if isNumber value then builtins.fromJSON value
    else value;

  # Hyprlang's direction shortcuts become the full names used by the Lua API.
  direction = value:
    if value == "l" then "left"
    else if value == "r" then "right"
    else if value == "u" then "up"
    else if value == "d" then "down"
    else value;

  parseCurve = row:
    let
      fields = splitComma row;
      number = value: builtins.fromJSON value;
    in if builtins.length fields != 5 then
      throw "HyprNix Transpiler: expected 'name, x1, y1, x2, y2' for bezier, got: ${row}"
    else mkArgs [
      (builtins.elemAt fields 0)
      {
        type = "bezier";
        points = [
          [ (number (builtins.elemAt fields 1)) (number (builtins.elemAt fields 2)) ]
          [ (number (builtins.elemAt fields 3)) (number (builtins.elemAt fields 4)) ]
        ];
      }
    ];

  # `spring:name` is a HyprNix extension for the legacy-shaped input. It lets
  # the Nix source keep a familiar comma-separated animation declaration while
  # emitting the Lua API's `spring = "name"` field.
  parseAnimation = row:
    let
      fields = splitComma row;
      count = builtins.length fields;
      leaf = if count >= 1 then builtins.elemAt fields 0 else "";
      enabledValue = if count >= 2 then scalar (builtins.elemAt fields 1) else false;
      speed = if count >= 3 then scalar (builtins.elemAt fields 2) else 0;
      curve = if count >= 4 then builtins.elemAt fields 3 else "default";
      curveRef =
        if lib.hasPrefix "spring:" curve then { spring = lib.removePrefix "spring:" curve; }
        else { bezier = curve; };
    in if count < 4 then
      throw "HyprNix Transpiler: expected 'name, enabled, speed, curve[, style]' for animation, got: ${row}"
    else {
      inherit leaf speed;
      enabled = enabledValue == true || enabledValue == 1;
    } // curveRef
      // (if count >= 5 && builtins.elemAt fields 4 != "" then { style = builtins.elemAt fields 4; } else { });

  parseSpring = row:
    let
      fields = splitComma row;
      count = builtins.length fields;
      number = value: builtins.fromJSON value;
    in if count != 4 then
      throw "HyprNix Transpiler: expected 'name, mass, stiffness, damping' for spring, got: ${row}"
    else mkArgs [
      (builtins.elemAt fields 0)
      {
        type = "spring";
        mass = number (builtins.elemAt fields 1);
        stiffness = number (builtins.elemAt fields 2);
        # Current Hyprland Lua API calls this `damping` (not `dampening`).
        damping = number (builtins.elemAt fields 3);
      }
    ];

  # Variables are resolved at Nix evaluation time. This means the generated Lua
  # does not depend on a fragile ordering of local declarations and keybinds.
  resolveVariables = variables: value:
    lib.foldl'
      (acc: name: lib.replaceStrings [ name ] [ (toString variables.${name}) ] acc)
      value
      (builtins.attrNames variables);

  parseMonitor = row:
    let
      fields = splitComma row;
      count = builtins.length fields;
      output = if count > 0 then builtins.elemAt fields 0 else "";
      # Accept the historical shorthand from the supplied config as a fallback
      # monitor. The canonical Lua API uses an empty output + preferred mode.
      isFallback = output == "preferred";
    in
      if count < 4 then throw "HyprNix Transpiler: monitor needs four comma-separated fields, got: ${row}"
      else if isFallback then {
        output = "";
        mode = "preferred";
        position = "auto";
        scale = 1;
      }
      else {
        inherit output;
        mode = builtins.elemAt fields 1;
        position = builtins.elemAt fields 2;
        scale = scalar (builtins.elemAt fields 3);
      };

  parseEnv = variables: row:
    let
      fields = splitComma row;
      count = builtins.length fields;
    in if count < 2 then
      throw "HyprNix Transpiler: env needs 'NAME, VALUE', got: ${row}"
    else mkArgs [
      (resolveVariables variables (builtins.elemAt fields 0))
      (resolveVariables variables (lib.concatStringsSep "," (lib.lists.drop 1 fields)))
    ];

  # Turn a legacy key-modifier field into the canonical Lua shortcut string.
  parseKey = variables: mods: key:
    let
      resolvedMods = trim (resolveVariables variables mods);
      parts = words resolvedMods;
    in if resolvedMods == "" then key
       else lib.concatStringsSep " + " (parts ++ [ key ]);

  workspaceValue = value:
    let resolved = trim value;
    in if isNumber resolved then builtins.fromJSON resolved else resolved;

  dispatcherExpr = variables: dispatcher: arg:
    let
      resolvedArg = trim (resolveVariables variables arg);
      quoted = toLua resolvedArg;
      directionArg = toLua (direction resolvedArg);
      workspaceLua = toLua (workspaceValue resolvedArg);
    in
      if dispatcher == "exec" then inline "hl.dsp.exec_cmd(${quoted})"
      else if dispatcher == "killactive" then inline "hl.dsp.window.close()"
      else if dispatcher == "fullscreen" then inline "hl.dsp.window.fullscreen()"
      else if dispatcher == "togglefloating" then inline "hl.dsp.window.float({ action = \"toggle\" })"
      else if dispatcher == "pseudo" then inline "hl.dsp.window.pseudo()"
      else if dispatcher == "layoutmsg" then inline "hl.dsp.layout(${quoted})"
      else if dispatcher == "movefocus" then inline "hl.dsp.focus({ direction = ${directionArg} })"
      else if dispatcher == "workspace" then inline "hl.dsp.focus({ workspace = ${workspaceLua} })"
      else if dispatcher == "movetoworkspace" then inline "hl.dsp.window.move({ workspace = ${workspaceLua} })"
      else if dispatcher == "togglespecialworkspace" then inline "hl.dsp.workspace.toggle_special(${quoted})"
      else if dispatcher == "movewindow" && resolvedArg == "" then inline "hl.dsp.window.drag()"
      else if dispatcher == "resizewindow" && resolvedArg == "" then inline "hl.dsp.window.resize()"
      else if dispatcher == "exit" then inline "hl.dsp.exit()"
      else throw "HyprNix Transpiler: unsupported legacy dispatcher '${dispatcher}' in bind. Add an explicit Lua mapping in lib/hyprland-transpiler.nix.";

  parseBind = variables: classic: kind: row:
    let
      allFields = splitComma row;
      count = builtins.length allFields;
      fail = throw "HyprNix Transpiler: bind should look like 'MOD, KEY, dispatcher[, argument]', got: ${row}";
      mods = if count >= 1 then builtins.elemAt allFields 0 else "";
      key = if count >= 2 then builtins.elemAt allFields 1 else "";
      dispatcher = if count >= 3 then builtins.elemAt allFields 2 else "";
      arg = if count >= 4 then trim (lib.concatStringsSep "," (lib.lists.drop 3 allFields)) else "";
      shortcut = parseKey variables mods key;
      inferredFlags =
        (if kind == "bindm" then { mouse = true; } else { })
        // (if kind == "bindl" || kind == "bindel" then { locked = true; } else { })
        // (if kind == "bindel" then { repeating = true; } else { });
      extraFlags = ((classic.bindFlags or { }).${shortcut} or { });
      flags = inferredFlags // extraFlags;
      apiArgs = [ shortcut (dispatcherExpr variables dispatcher arg) ]
        ++ (if flags == { } then [ ] else [ flags ]);
    in if count < 3 then fail else mkArgs apiArgs;

  parseRuleToken = token:
    let
      matchFields = builtins.match "match:([^ ]+)[ ]+(.+)" token;
      actionFields = builtins.match "([^ ]+)[ ]+(.+)" token;
    in if matchFields != null then {
      section = "match";
      name = builtins.elemAt matchFields 0;
      value = scalar (builtins.elemAt matchFields 1);
    } else if actionFields != null then {
      section = "action";
      name = builtins.elemAt actionFields 0;
      value = scalar (builtins.elemAt actionFields 1);
    } else throw "HyprNix Transpiler: can't parse rule segment '${token}'";

  tokensToAttrs = section: tokens:
    builtins.listToAttrs (map
      (token: { inherit (token) name; value = token.value; })
      (builtins.filter (token: token.section == section) tokens));

  parseRule = prefix: names: index: row:
    let
      tokens = map parseRuleToken (map trim (lib.splitString "," row));
      matches = tokensToAttrs "match" tokens;
      actions = tokensToAttrs "action" tokens;
      ruleName = if index < builtins.length names then builtins.elemAt names index
                 else "legacy-${prefix}-${toString (index + 1)}";
    in (optionalAttrs (matches != { }) { match = matches; })
       // actions
       // { name = ruleName; };

  parseGeneral = general:
    let
      activeKey = "col.active_border";
      inactiveKey = "col.inactive_border";
      hasActive = has activeKey general;
      hasInactive = has inactiveKey general;
      active = if hasActive then words general.${activeKey} else [ ];
      base = builtins.removeAttrs general [ activeKey inactiveKey ];
      existingCol = base.col or { };
      activeValue = if builtins.length active >= 3 then {
        colors = [ (builtins.elemAt active 0) (builtins.elemAt active 1) ];
        angle = builtins.fromJSON (lib.removeSuffix "deg" (builtins.elemAt active 2));
      } else throw "HyprNix Transpiler: couldn't parse general.col.active_border '${general.${activeKey}}'";
      col = existingCol
        // (optionalAttrs hasActive { active_border = activeValue; })
        // (optionalAttrs hasInactive { inactive_border = general.${inactiveKey}; });
    in base // (optionalAttrs (col != { }) { inherit col; });

in classic:
let
  variables = builtins.listToAttrs (map
    (name: {
      name = name;
      value = classic.${name};
    })
    (builtins.filter (name: lib.hasPrefix "$" name) (builtins.attrNames classic)));

  resolve = value: resolveVariables variables value;

  ordinaryKeys = [
    "$mainMod" "$terminal" "$fileManager" "$menu"
    "monitor" "env" "exec-once"
    "bind" "bindm" "bindl" "bindel"
    "windowrule" "layerrule" "gesture" "device" "bindFlags"
    "windowRuleNames" "layerRuleNames"
    "animations"
  ];

  normalConfig = builtins.removeAttrs classic (ordinaryKeys ++ builtins.attrNames variables);
  configWithGeneral = normalConfig // (optionalAttrs (has "general" normalConfig) {
    general = parseGeneral normalConfig.general;
  });
  # `animations` is excluded from normalConfig because its legacy `bezier`
  # and `animation` lists are emitted as their own top-level Lua calls. Keep
  # only the global enabled flag under hl.config({ animations = ... }).
  configWithAnimations = configWithGeneral // (optionalAttrs (has "animations" classic) {
    animations = { enabled = (classic.animations.enabled or true); };
  });

  monitors = map parseMonitor (classic.monitor or [ ]);
  envs = map (parseEnv variables) (classic.env or [ ]);
  bindGroups = lib.concatLists (map
    (kind: map (parseBind variables classic kind) (classic.${kind} or [ ]))
    [ "bind" "bindm" "bindl" "bindel" ]);

  curves = map parseCurve ((classic.animations or { }).bezier or [ ])
    ++ map parseSpring ((classic.animations or { }).spring or [ ]);
  animations = map parseAnimation ((classic.animations or { }).animation or [ ]);
  devices = classic.device or [ ];
  gestures = map (row:
    let fields = splitComma row;
    in if builtins.length fields != 3 then
      throw "HyprNix Transpiler: gesture should look like 'FINGERS, DIRECTION, ACTION', got: ${row}"
    else {
      fingers = scalar (builtins.elemAt fields 0);
      direction = builtins.elemAt fields 1;
      action = builtins.elemAt fields 2;
    }
  ) (classic.gesture or [ ]);

  commands = builtins.filter
    (command: !(lib.hasPrefix "systemctl enable --now --user hyprpolkitagent" (trim command)))
    (map resolve (classic."exec-once" or [ ]));
  startup = mkArgs [
    "hyprland.start"
    (inline ("function()\n" + lib.concatMapStringsSep "\n" (command: "  hl.exec_cmd(${toLua command})") commands + "\nend"))
  ];

  windowRules = lib.imap0 (index: row: parseRule "window" (classic.windowRuleNames or [ ]) index row) (classic.windowrule or [ ]);
  layerRules = lib.imap0 (index: row: parseRule "layer" (classic.layerRuleNames or [ ]) index row) (classic.layerrule or [ ]);
in
  { config = configWithAnimations; }
  // optionalAttrs (monitors != [ ]) { monitor = monitors; }
  // optionalAttrs (envs != [ ]) { env = envs; }
  // optionalAttrs (bindGroups != [ ]) { bind = bindGroups; }
  // optionalAttrs (curves != [ ]) { curve = curves; }
  // optionalAttrs (animations != [ ]) { animation = animations; }
  // optionalAttrs (devices != [ ]) { device = devices; }
  // optionalAttrs (gestures != [ ]) { gesture = gestures; }
  // optionalAttrs (commands != [ ]) { on = startup; }
  // optionalAttrs (windowRules != [ ]) { window_rule = windowRules; }
  // optionalAttrs (layerRules != [ ]) { layer_rule = layerRules; }
