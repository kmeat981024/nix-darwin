# nix-darwin

`nix-darwin`, `home-manager`, `nix-homebrew`, `sops-nix` 기반의 선언적 macOS
설정 저장소입니다.

## 이 저장소가 관리하는 것

- `hosts/`의 시스템 레벨 macOS 설정
- `home/`의 사용자 레벨 도구/셸/터미널/에디터 설정
- `hosts/apps.nix`의 선언적 Homebrew tap/app/cask 관리
- `secrets/` + `.sops.yaml`의 SOPS 암호화 시크릿

## 사전 요구사항

- Apple Silicon macOS (`aarch64-darwin`)
- flakes가 활성화된 Nix (`nix-command` + `flakes`)
- `just` (명령 실행기)
- 아래 경로의 SOPS age 키:

```bash
~/.config/sops/age/keys.txt
```

## 저장소 구조

- `flake.nix`: flake input/output 및 `darwinConfigurations`
- `Justfile`: 일상 명령(`darwin`, `darwin-debug`, `fmt`, `up`, `gc` 등)
- `hosts/`: 시스템 모듈
  - `default.nix`
  - `nix-core.nix`
  - `system.nix`
  - `apps.nix`
  - `host-users.nix`
- `home/`: Home Manager 모듈(`git.nix`, `zsh.nix`, `nvf/`, `aerospace.nix` 등)
- `secrets/`: 암호화된 시크릿 파일(`poby.yaml`)

## 자주 쓰는 명령

```bash
# 사용 가능한 작업 보기
just

# 현재 머신 hostname 기준으로 빌드 및 스위치
just darwin $(hostname)

# trace/verbose 로그와 함께 빌드 및 스위치
just darwin-debug $(hostname)

# Nix 파일 포맷팅(저장소 루트 기준)
just fmt .

# flake input 전체 업데이트
just up

# 특정 input 하나만 업데이트
just upp nixpkgs-darwin

# 스위치 없이 빌드 검증(예시 호스트: fenrir)
nix build .#darwinConfigurations.fenrir.system --extra-experimental-features 'nix-command flakes'

# 시스템 프로필 히스토리 확인 / 오래된 generation 정리
just history
just clean
just gc
```

## 설정 노트

- `flake.nix`는 현재 `hostname` 기반으로 하나의 `darwinConfigurations` 항목을
  만들고, 시스템 모듈은 `./hosts`에서 import 합니다.
- `home/default.nix`에서 사용자 모듈(셸, git, nvf, aerospace, sops, ssh)을
  조합합니다.
- Aerospace 멀티 모니터 워크스페이스 할당은 `home/aerospace.nix`에 있습니다.
- 자주 업데이트되는 앱은 Homebrew 중심으로 `hosts/apps.nix`에서 관리합니다.

## 시크릿

- 시크릿은 `secrets/*.yaml`에 암호화해서 보관합니다.
- `.sops.yaml`이 `secrets/.*\.yaml`에 대한 암호화 규칙을 강제합니다.
- Home Manager는 `home/sops.nix`를 통해 `secrets/poby.yaml`에서 아래 항목을
  읽습니다.
  - `github_ssh_key`
  - `github_cli_token`

## 트러블슈팅

- 자세한 평가/빌드 로그가 필요하면 `just darwin-debug <hostname>`을 사용하세요.
- 특정 호스트 평가가 실패하면 해당 호스트가 `darwinConfigurations`에 정의됐는지
  확인하세요.
- 빌드 성공 후에도 설정 반영이 이상하면 switch를 다시 실행하고 활성
  hostname/config를 확인하세요.
