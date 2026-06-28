# Secrets

This directory stores SOPS-encrypted secrets used by the `secrets` Home Manager
aspect. Do not commit plaintext secrets.

## Current Setup

- Secret file: `secrets/poby.yaml`
- SOPS rules: `.sops.yaml`
- Age key file: `~/.config/sops/age/keys.txt`
- Environment variable: `SOPS_AGE_KEY_FILE`, exported by the `secrets` aspect
- SOPS CLI: installed by the system packages aspect
- Secret declarations: `modules/aspects/_secrets/sops.nix`
- SSH host wiring: `modules/aspects/_ssh/ssh.nix`
- Declared secret names:
  - `github_ssh_key`
  - `github_cli_token`
  - `kmeat_mac_mini_ssh_key`

## Add An SSH Private Key

From the repository root, open the encrypted secret file:

```bash
sops secrets/poby.yaml
```

Add a top-level key name and paste the private key as a YAML block scalar. The
key name should match the Nix declaration you will add later.

```yaml
workstation_ssh_key: |
  -----BEGIN OPENSSH PRIVATE KEY-----
  ...
  -----END OPENSSH PRIVATE KEY-----
```

Save and quit the editor. SOPS will re-encrypt the file automatically.

Do not edit the `sops:` metadata block manually.

If this machine has not applied the Home Manager config yet, set the age key
file explicitly for the command:

```bash
SOPS_AGE_KEY_FILE="$HOME/.config/sops/age/keys.txt" sops secrets/poby.yaml
```

If the system package set has not been applied yet, run the command from a
temporary shell with `sops`:

```bash
nix-shell -p sops --run 'sops secrets/poby.yaml'
```

## Generate A New SSH Key First

If the key does not exist yet, generate it before opening SOPS:

```bash
ssh-keygen -t ed25519 -f ~/.ssh/workstation_ssh_key -C "workstation"
```

Register the public key wherever the remote service expects it:

```bash
cat ~/.ssh/workstation_ssh_key.pub
```

Then copy the private key contents into `secrets/poby.yaml` with SOPS.

After the private key is stored in SOPS and deployed through `sops-nix`, remove
any temporary plaintext private key if it is no longer needed outside this repo.

## Declare The Secret In Nix

Add the secret name to `modules/aspects/_secrets/sops.nix`:

```nix
secrets = {
  "github_ssh_key" = {};
  "github_cli_token" = {};
  "kmeat_mac_mini_ssh_key" = {};
  "workstation_ssh_key" = {};
};
```

The `secrets` aspect sets `sops.defaultSopsFile` from
`repo.user.secretFile`, which defaults to `secrets/poby.yaml` in
`modules/flake/options.nix`.

## Use The Secret For SSH

Reference the SOPS-managed secret path from the matching SSH host block in
`modules/aspects/_ssh/ssh.nix`:

```nix
"workstation-host" = {
  hostname = "example.com";
  user = "example";
  identitiesOnly = true;
  identityFile = [config.sops.secrets."workstation_ssh_key".path];
};
```

## Verify

Confirm the encrypted file contains the expected top-level secret names without
printing secret values:

```bash
sops -d secrets/poby.yaml \
  | awk -F: '/^[A-Za-z0-9_]+:/ { print $1 }'
```

Confirm no plaintext private key was written into the encrypted file:

```bash
rg -n "BEGIN OPENSSH PRIVATE KEY|END OPENSSH PRIVATE KEY" secrets/poby.yaml
```

Expected result: no output.

Check that every secret referenced by SSH is declared in SOPS before switching:

```bash
rg 'config\.sops\.secrets' modules/aspects/_ssh/ssh.nix
```

Evaluate the Darwin configuration:

```bash
nix build .#darwinConfigurations.fenrir.system \
  --dry-run \
  --extra-experimental-features 'nix-command flakes'
```

Build and switch:

```bash
just darwin fenrir
```

Test the SSH alias:

```bash
ssh -o BatchMode=yes workstation-host true
```

No output means the SSH command succeeded.
