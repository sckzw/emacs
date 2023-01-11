;;; 日本語環境設定
;; 言語設定
(set-language-environment "Japanese")
;; 優先文字コード
(prefer-coding-system 'utf-8-unix)
;; ファイル名の文字コード
(setq default-file-name-coding-system 'utf-8-unix)
;; バッファの文字コード
;(setq buffer-file-coding-system 'utf-8-unix)
;; ターミナルで起動するときの文字コード
;(set-terminal-coding-system 'utf-8-unix)
;;
;(set-default-coding-systems 'utf-8-unix)

(when (eq system-type 'windows-nt)
  ;;; 日本語入力
  (setq default-input-method "W32-IME")
  ;; 日本語入力の文字コード
  (set-keyboard-coding-system 'sjis)
  ;; モードラインのインジケータ設定
  (setq-default w32-ime-mode-line-state-indicator "(Aa)")
  (setq w32-ime-mode-line-state-indicator-list '("(Aa)" "(あ)" "(Aa)"))
  ;; ON/OFF時のカーソル色設定
  (set-cursor-color "brown")
  (add-hook 'input-method-activate-hook   (lambda() (set-cursor-color "brown")))
  (add-hook 'input-method-inactivate-hook (lambda() (set-cursor-color "wheat")))
  ;; バッファ切り替え時にIME状態を引き継ぐ
  (setq w32-ime-buffer-switch-p nil)
  ;; 初期化
  (w32-ime-initialize)
  )

;;; Lisp
;; ロードパス設定
(add-to-list 'load-path "~/.emacs.d/lisp")
;; カスタマイズファイル設定
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(setq package-archive-priorities '(("gnu" . 15) ("nongnu" . 10) ("melpa-stable" . 5)))
(package-initialize)

;;; バックアップ
;; 対象ファイルとバックアップ先ディレクトリ設定
(setq backup-directory-alist '((".*" . "~/.emacs.d/backup")))

;;; recentf
(recentf-mode 1)

;;; Desktop
;; (desktop-save-mode 1)
;; ;; セッション保存対象を指定
;; (add-to-list 'desktop-globals-to-save 'file-name-history)
;; (add-to-list 'desktop-globals-to-save 'extended-command-history)
;; ;; ;; すべてのファイルのセッションを保存する
;; (setq desktop-files-not-to-save "^$")

;;; ウィンドウ
;; スプラッシュ画面を無効化
(setq inhibit-startup-message t)
;; ビープ音を無効化
(setq ring-bell-function 'ignore)
;; タイトルバーにファイル名を表示
(setq frame-title-format "%b")
;; ツールバーを非表示
(tool-bar-mode -1)

;;; モードライン
;; 行番号をモードラインに表示
(line-number-mode t)
;; 桁番号をモードラインに表示
(column-number-mode t)
;; 改行コードを表示
(setq eol-mnemonic-dos "(CL)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;;; インデント
;; インデントにタブを用いない
(setq-default indent-tabs-mode nil)
;; タブ幅を4に設定
(setq-default tab-width 4)

;;; リージョン
;; 選択で自動コピーしない
(setq mouse-drag-copy-region nil)
;; 選択範囲の一括削除
(delete-selection-mode t)

;;; バッファ
;; 長い行を折り返さない
(setq-default truncate-lines t)
(setq-default truncate-partial-width-windows t)
;; 対応するカッコをハイライト
(show-paren-mode t)

;;; ミニバッファ
;; "yes or no" を "y or n" にする
(fset 'yes-or-no-p 'y-or-n-p)

;;; 検索
;; 検索で大文字/小文字を区別する(M-cで切り替え可能)
(setq-default case-fold-search nil)

;;; キーバインド
;; バッファ一覧を変更
;(global-set-key "\C-x\C-b" 'bs-show)
;; バッファ移動をShift + カーソルで行う
(windmove-default-keybindings)
;; バッファ移動をループさせる
(setq windmove-wrap-around t)

;;; マウス
;; マウスホイールによるスクロール速度を一定にする
(setq mouse-wheel-progressive-speed nil)
;; マウスホイールで3行スクロールする
(setq mouse-wheel-scroll-amount (quote (3 ((shift) . 1) ((control)))))

;; after init
(add-hook 'after-init-hook
  (lambda ()
    ;; show init time
    (message "init time: %.3f sec"
             (float-time (time-subtract after-init-time before-init-time)))))

;;; cua-mode
;; 矩形編集を有効にする
(cua-mode t)
(setq cua-enable-cua-keys nil)

;;; hl-line-mode
;; カーソル行を強調する
(global-hl-line-mode)

;;; vc
;; 無効にする
(setq vc-handled-backends nil)

(use-package consult
  :bind
  (("C-x b" . consult-buffer)
   ("M-g g" . consult-goto-line)
   ("M-y"   . consult-yank-pop))
  :config
  (consult-customize
   consult-theme consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   :preview-key '(:debounce 0.5 any)))

(use-package corfu
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-cycle t))

(use-package eglot
  :hook
  (verilog-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-stay-out-of 'flymake)
  (add-to-list 'eglot-server-programs '(verilog-mode . ("veridian")))
  :custom
  (completion-category-defaults nil))

(use-package flycheck
  :hook
  (verilog-mode)
  :config
  (flycheck-define-checker verilog-verilator
    "A Verilog syntax checker using the Verilator Verilog HDL simulator."
    :command
    ("verilator_bin" "--lint-only" "-Wall" "--quiet-exit"
     (eval verilog-library-flags) source)
    :error-patterns
    ((warning line-start "%Warning"
              (? "-" (id (+ (any "0-9A-Z_")))) ": "
              (? (file-name) ":" line ":" (? column ":") " ")
              (message) line-end)
     (error line-start "%Error"
            (? "-" (id (+ (any "0-9A-Z_")))) ": "
            (? (file-name) ":" line ":" (? column ":") " ")
            (message) line-end))
    :modes
    (verilog-mode)))

(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package multiple-cursors
  :bind
  (("C-*" . mc/edit-lines)
   ("C->" . mc/mark-next-like-this)
   ("C-<" . mc/mark-previous-like-this)))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package verilog-mode
  :custom
  (verilog-indent-level                4   )
  (verilog-indent-level-module         4   )
  (verilog-indent-level-declaration    4   )
  (verilog-indent-lists                nil )
  (verilog-indent-level-behavioral     4   )
  (verilog-indent-level-directive      4   )
  (verilog-cexp-indent                 4   )
  (verilog-case-indent                 4   )
  (verilog-auto-newline                nil )
  (verilog-auto-indent-on-newline      nil )
  (verilog-indent-begin-after-if       nil )
  (verilog-align-ifelse                nil )
  (verilog-minimum-comment-distance    40  )
  (verilog-highlight-grouping-keywords t   )
  (verilog-highlight-modules           t   )
  (verilog-highlight-includes          t   )
  (verilog-auto-lineup                 nil )
  (verilog-linter "verilator_bin --lint-only -Wall")
  :config
  ;; 数値リテラルのフェイス設定
  (font-lock-add-keywords
   'verilog-mode
   '(("\\(\\<[1-9][0-9_]*\\)?'h[0-9_a-fxz]+\\>" . font-lock-string-face)   ; 16進数
     ("\\(\\<[1-9][0-9_]*\\)?'d[0-9_xz]+\\>"    . font-lock-string-face)   ; 10進数
     ("\\(\\<[1-9][0-9_]*\\)?'o[0-7_xz]+\\>"    . font-lock-string-face)   ; 8進数
     ("\\(\\<[1-9][0-9_]*\\)?'b[01_xz]+\\>"     . font-lock-string-face)   ; 2進数
     ("\\<[0-9][0-9_]*\\>"                      . font-lock-string-face))) ; 基数なし
  )

(use-package vertico
  :init
  (vertico-mode))

(use-package visual-regexp-steroids
  :bind
  (("C-M-s" . vr/isearch-forward)
   ("C-M-r" . vr/isearch-backward)
   ("C-M-%" . vr/query-replace)
   ("C-c m" . vr/mc-mark))
  :custom
  (vr/engine 'pcre2el))

(use-package whitespace
  :init
  (global-whitespace-mode)
  :custom
  (whitespace-style
   '(face
     trailing
     lines-tail
     empty
     space-after-tab
     space-before-tab
     space-mark
     tab-mark
     newline-mark))
  (whitespace-display-mappings
   '((space-mark ?\u3000 [?﹏])
     (newline-mark ?\n [?↵ ?\n])
     (tab-mark ?\t [?\t ?⇥] [?\\ ?\t]))))

(use-package yasnippet
  :hook
  (verilog-mode . yas-minor-mode))

;;; init.el ends here
