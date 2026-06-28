# nix-darwin

`nix-darwin`, `home-manager`, `nix-homebrew`, `sops-nix` 기반의 선언적 macOS
설정 저장소입니다. 작은 aspect 모듈을 조합해 macOS 호스트를 만들고,
Home Manager는 nix-darwin 안에 통합해서 사용합니다.

## 이 저장소가 관리하는 것

- `modules/flake/`의 flake 조립 및 호스트 구성 생성
- `modules/aspects/`의 자동 발견 Darwin/Home Manager aspect
- `hosts/`의 자동 발견 멀티 호스트 선언
- `secrets/` + `.sops.yaml`의 SOPS 암호화 시크릿
- 사용자 `poby`의 에디터, 브라우저, 터미널, 쉘, 데스크톱, SSH, CLI 도구
  설정

## 사전 요구사항

- Apple Silicon macOS (`aarch64-darwin`)
- flakes가 활성화된 Nix (`nix-command` + `flakes`)
- `just` (명령 실행기)
- 아래 경로의 SOPS age 키:

```bash
~/.config/sops/age/keys.txt
```

## 저장소 구조

- `flake.nix`: `flake-parts` 진입점과 flake input
- `Justfile`: 일상 명령(`dry-run`, `darwin`, `darwin-debug`, `fmt`, `up`,
  `upp`, `repl`, `history`, `clean`, `gc`, `gcroot` 등)
- `modules/flake/`: 저장소 옵션, Darwin 조립, 공유 context 모듈
- `modules/aspects/`: `base`, `homebrew`, `shell`, `hammerspoon`, `editor`,
  `browser`, `discord`, `desktop` 같은 이름 있는 자동 발견 aspect 진입 모듈
- `modules/aspects/_*/`: 공개 aspect를 뒷받침하는, 자동 로딩에서 제외되는
  내부 구현 트리
- `modules/aspects/_hammerspoon/`: `$HOME/.hammerspoon`으로 연결되는
  Hammerspoon 설정
- `modules/aspects/_editor/`: NVF와 Zed 에디터 설정
- `modules/aspects/_browser/`: Zen Browser 정책, 프로필 설정, 확장,
  컨테이너, 스페이스, 고정 탭 설정
- `modules/aspects/_secrets/`: `sops-nix` 선언과 Home Manager 세션 변수
- `hosts/`: `system`과 flat `features` 목록을 등록하는 자동 발견 호스트 선언
- `secrets/`: 암호화된 시크릿 파일(`poby.yaml`)

## 자주 쓰는 명령

```bash
# 사용 가능한 작업 보기
just

# 현재 머신 hostname 기준으로 빌드 및 스위치
just darwin $(hostname)

# trace/verbose 로그와 함께 빌드 및 스위치
just darwin-debug $(hostname)

# 실제 빌드 없이 의존성 그래프 검증
just dry-run fenrir

# Nix 파일 포맷팅(저장소 루트 기준)
just fmt .

# flake input 전체 업데이트
just up

# 특정 input 하나만 업데이트
just upp nixpkgs

# 스위치 없이 빌드 검증(예시 호스트: fenrir)
nix build .#darwinConfigurations.fenrir.system --extra-experimental-features 'nix-command flakes'

# 같은 검증을 raw Nix 명령으로 실행
nix build .#darwinConfigurations.fenrir.system --dry-run --extra-experimental-features 'nix-command flakes'

# 시스템 프로필 히스토리 확인 / 오래된 generation 정리 / 미사용 store 경로 정리
just history
just clean
just gc
```

## 설정 노트

- `flake.nix`는 `flake-parts`를 사용하고 `./modules/flake`는 명시적으로
  유지한 채 `import-tree`로 `./modules/aspects`와 `./hosts`를 자동 발견합니다.
- `hosts/fenrir.nix`가 현재 호스트 선언이며 `fenrir`를 하나의 flat feature
  목록에 매핑합니다.
- `modules/flake/darwin-configurations.nix`가 각 호스트의
  `darwinConfigurations.<host>`를 만들고, 사용자 `poby`의 Home Manager를
  nix-darwin 안에 통합합니다.
- `modules/aspects/`가 호스트가 선택하는 기능 vocabulary입니다. 현재 feature
  집합은 `base`, `nix-core`, `system-packages`, `homebrew`,
  `macos-defaults`, `activation`, `fonts`, `sudo-auth`, `shell`,
  `cli-tools`, `git`, `ssh`, `secrets`, `terminal`, `hammerspoon`, `editor`,
  `browser`, `discord`, `desktop`, `fenrir` 입니다.
- `cli-tools` aspect가 `zoxide`를 포함한 CLI 사용자 도구 묶음을 담당합니다.
- `editor` aspect는 NVF와 Zed를 함께 가져옵니다. Zed는 Home Manager로
  설정하며 사용자 설정과 keymap의 mutable 옵션을 켜고, `nix` 확장,
  Nix language server로 `nixd`, Nix formatter로 Alejandra를 사용합니다.
- `browser` aspect는 Home Manager로 Zen Browser를 관리하며,
  `modules/aspects/_browser/` 아래의 브라우저 정책과 프로필 모듈을
  포함합니다.
- Hammerspoon 앱은 `homebrew` cask 목록으로 설치하고, `hammerspoon`
  aspect는 Home Manager로 `modules/aspects/_hammerspoon/`을
  `$HOME/.hammerspoon`에 연결합니다.
- `modules/aspects/_*/`는 자동 발견에서 제외되는 내부 구현 경로입니다.
  이 저장소는 `/_`가 포함된 경로를 `import-tree`가 건너뛴다는 규칙을 사용해
  NVF 같은 서브트리를 보호합니다.
- Home Manager는 nix-darwin을 통해 통합되며, 별도의 `homeConfigurations`
  출력은 만들지 않습니다.

## 호스트 추가 방법

- `hosts/<hostname>.nix` 파일을 만듭니다.
- `repo.hosts.<hostname>.system`을 등록합니다.
- `repo.hosts.<hostname>.features`에 사용할 aspect 이름 목록을 등록합니다.
- 호스트 전용 동작은 공유 feature를 수정하지 말고 `modules/aspects/`에 새
  aspect로 추가합니다.

## 시크릿

- 시크릿은 `secrets/*.yaml`에 암호화해서 보관합니다.
- `.sops.yaml`이 `secrets/.*\.yaml`에 대한 암호화 규칙을 강제합니다.
- Home Manager는 `secrets` aspect를 통해 `secrets/poby.yaml`에서 아래 항목을
  읽습니다.
  - `github_ssh_key`
  - `github_cli_token`
  - `kmeat_mac_mini_ssh_key`

## 트러블슈팅

- 자세한 평가/빌드 로그가 필요하면 `just darwin-debug <hostname>`을 사용하세요.
- 특정 호스트 평가가 실패하면 해당 호스트가 `darwinConfigurations`에 정의됐는지
  확인하세요.
- 의존성 그래프만 확인하고 싶다면
  `nix build .#darwinConfigurations.<host>.system --dry-run`을 먼저 실행하세요.
- 빌드 성공 후에도 설정 반영이 이상하면 switch를 다시 실행하고 활성
  hostname/config를 확인하세요.
