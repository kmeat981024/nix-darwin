# nix-darwin

`nix-darwin`, `home-manager`, `nix-homebrew`, `sops-nix`를 사용해 호스트
`fenrir`를 선언적으로 관리하는 macOS 설정 저장소입니다.

## 이 저장소가 관리하는 것

- 시스템 레벨 macOS 설정(`modules/`)
- 사용자 레벨 도구 및 셸/에디터 설정(`home/`)
- 선언적 Homebrew tap/app/cask
- SOPS 기반 암호화 시크릿(`secrets/` + `.sops.yaml`)

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
- `modules/`: 시스템 모듈(`nix-core.nix`, `system.nix`, `apps.nix`,
  `host-users.nix`)
- `home/`: Home Manager 모듈(셸, git, nvf, 터미널, 도구)
- `secrets/`: 암호화된 시크릿 파일(`poby.yaml`)

## 자주 쓰는 명령

```bash
# 사용 가능한 작업 보기
just

# 호스트용 빌드 및 스위치
just darwin $(hostname)

# 전체 trace와 함께 빌드 및 스위치
just darwin-debug $(hostname)

# Nix 파일 포맷팅(예: 저장소 전체)
just fmt .

# flake input 전체 업데이트
just up

# 특정 input 하나만 업데이트
just upp nixpkgs-darwin

# 시스템 프로필 히스토리 확인
just history

# 오래된 generation 정리 / 가비지 컬렉션
just clean
just gc
```

## 시크릿

- 시크릿은 `secrets/*.yaml`에 암호화되어 저장됩니다.
- `.sops.yaml`이 age 기반 암호화 규칙을 강제합니다.
- Home Manager는 `secrets/poby.yaml`에서 아래 항목을 읽어 사용합니다:
  - `github_ssh_key`
  - `github_cli_token`

## 커스터마이징 노트

- `flake.nix`의 `hostname`, `username`, `useremail`을 환경에 맞게 수정하세요.
- 새 시스템 동작은 `modules/*.nix`에 추가하세요.
- 사용자 도구는 `home/*.nix`에 추가하고 `home/default.nix`에서 import 하세요.

## 트러블슈팅

- 자세한 평가/빌드 출력이 필요하면 `just darwin-debug <hostname>`을 사용하세요.
- 빌드는 성공했는데 동작이 반영되지 않으면 switch를 다시 실행하고 활성
  host/config 값을 확인하세요.
