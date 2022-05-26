# SAEMC Vim Settings

### 사용 플러그인

- `Plug 'airblade/vim-gitgutter'`
- `Plug 'ap/vim-css-color'`
- `Plug 'blueyed/vim-diminactive'`
- `Plug 'jiangmiao/auto-pairs'`
- `Plug 'jistr/vim-nerdtree-tabs'`
- `Plug 'nathanaelkane/vim-indent-guides'`
- `Plug 'navarasu/onedark.nvim'`
- `Plug 'ojroques/vim-oscyank', {'branch': 'main'}`
- `Plug 'preservim/nerdcommenter'`
- `Plug 'preservim/tagbar'`
- `Plug 'neoclide/coc.nvim', {'branch': 'release'}`
- `Plug 'scrooloose/nerdtree'`
- `Plug 'tpope/vim-fugitive'`
- `Plug 'tpope/vim-surround'`
- `Plug 'vim-airline/vim-airline'`
- `Plug 'vim-airline/vim-airline-themes'`

---

### 준비 사항

- `sudo` 및 `git` 설치
  > Mac은 XCode/Homebrew가 이미 설치되어 있는 환경

```bash
$ (sudo) apt-get update && \
  (sudo) apt-get install -y sudo git
```

- SAEMC Vim-Settings 프로젝트 다운로드 및 실행
  > `$ ./vim_settings.sh -a` -> Dependencies/Plugins 설치 후 Scripts 작성  
  > `$ ./vim_settings.sh -d` -> Dependencies만 설치  
  > `$ ./vim_settings.sh -p` -> Plugins만 설치 (작성되어 있는 Scripts 제거됨)  
  > `$ ./vim_settings.sh -s` -> Scripts만 작성

```bash
$ git clone https://github.com/SAEMC/Vim-Settings && \
  cd ./Vim-Settings
$ ./vim_settings.sh [OPTIONS]
```

- Dependencies 설치 활성화 (Plugins만 설치 및 Scripts만 작성은 제외)
  > Linux인 경우

```bash
$ source ~/.bashrc
```

> Mac인 경우

```bash
$ source ~/.zshrc
```

---

### 사용 방법

#### [N: Normal] | [V: Visual] | [I: Insert] | [T: Terminal]

#### 매핑된 커맨드는 `~/.vimrc` 파일 확인

#### 이외의 커맨드는 Vim 기본 커맨드 (Vim 기본 커맨드 참조)

<br/>

##### [N]

- `<Space>` + `b`: NerdTree 토글 (VSCode - Tree Open)
- `<Space>` + `d`: 버퍼 윈도우 닫기 (CLI - Exit)
- `<Space>` + `e`: 저장 전 변경된 내용 확인 (Edited)
- `<Space>` + `h`: 터미널 수평 분할 (Horizontal)
- `<Space>` + `l`: `/search` 결과 / `:set list` 끄기 (CLI - Clear)
- `<Space>` + `m`: 커서 기준 단어 수정 (Modify)
- `<Space>` + `n`: 라인 넘버링 토글 (Number)
- `<Space>` + `p`: CoC 검사 / GitGutter 플러그인 표시 토글 (Plugins)
- `<Space>` + `r`: 버퍼 윈도우 새로고침 (Refresh)
- `<Space>` + `t`: Tagbar 토글 (Tagbar)
- `<Space>` + `v`: 터미널 수직 분할 (Vertical)
- `<Space>` + `[` or `]`: 버퍼 윈도우 이동
- `<Space>` + `=`: 분할된 윈도우 크기 동일하게 조절

##### [V]

- `<Space>` + `f`: 코드 폴딩 토글 (Fold)
- `<Space>` + `m`: 선택된 부분 수정 (Modify)
- `<Space>` + `s`: 선택된 부분 서라운드 (Surround)
- `<Space>` + `y`: OS 클립보드로 복사 (Yank)
- `<Space>` + `,`: 주석 토글 (VSCode - Comments)

##### [I]

- `Ctrl` + `d`: 커서 포함 다음 글자 제거 (Delete)
- `Ctrl` + [`h` or `j` or `k` or `l`]: 커서 이동

##### [T]

- `Ctrl` + `w` + [`h` or `j` or `k` or `l`]: 윈도우 이동

##### [NerdTree 윈도우]

- `<Space>` + `c`: NerdTree 현재 디렉터리 변경 (Change)
- `<Space>` + `e`: NerdTree 윈도우 확장 토글 (Extend)
- `<Space>` + `h`: NerdTree 윈도우 수평 분할 (Horizontal)
- `<Space>` + `r`: NerdTree 윈도우 새로고침 (Refresh)
- `<Space>` + `v`: NerdTree 윈도우 수직 분할 (Vertical)
