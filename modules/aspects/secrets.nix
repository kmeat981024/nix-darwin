{...}: {
  repo.homeModules.secrets = {
    imports = [
      ./_secrets
    ];
  };
}
