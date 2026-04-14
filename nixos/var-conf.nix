{ lib, ... }:

{
  options = {
    var = lib.mkOption {
      type = lib.types.submodule {
        options = {
          username = lib.mkOption {
            type = lib.types.str;
            description = "Username for the system";
          };
          powerKeyAction = lib.mkOption {
            type = lib.types.str;
            default = "ignore";
            description = "Action to take when power button is pressed";
          };
          git = lib.mkOption {
            type = lib.types.submodule {
              options = {
                username = lib.mkOption {
                  type = lib.types.str;
                  description = "Git user name";
                };
                email = lib.mkOption {
                  type = lib.types.str;
                  description = "Git user email";
                };
              };
            };
            default = {
              username = "";
              email = "";
            };
            description = "Git configuration";
          };
        };
      };
      default = {};
      description = "Custom configuration variables";
    };
  };
}
