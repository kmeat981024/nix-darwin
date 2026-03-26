{...}: {
  flake.modules.darwin.sudo-auth = {
    security.pam.services.sudo_local = {
      touchIdAuth = true;
      watchIdAuth = true;
    };
  };
}
