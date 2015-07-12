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

;;; Lisp
;; ロードパス設定
(add-to-list 'load-path "~/.emacs.d/lisp")
;; カスタマイズファイル設定
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;;; Package
(require 'package)
;; リポジトリ追加
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;; 初期化
(package-initialize)

;;; バックアップ
;; 対象ファイルとバックアップ先ディレクトリ設定
(setq backup-directory-alist '((".*" . "~/.emacs.d/backup")))

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
;; アクティブ時と非アクティブ時の透明度を設定
(add-to-list 'default-frame-alist '(alpha . (90 80)))

;;; フォント
(set-frame-font "Consolas 11")
;; Unicode
(set-fontset-font nil 'mule-unicode-0100-24ff (font-spec :family "Arial Unicode MS"))
(set-fontset-font nil 'mule-unicode-2500-33ff (font-spec :family "Arial Unicode MS"))
(set-fontset-font nil 'mule-unicode-e000-ffff (font-spec :family "Arial Unicode MS"))
;; 日本語
(set-fontset-font nil 'japanese-jisx0213.2004-1 (font-spec :family "MS Gothic"))
(set-fontset-font nil 'japanese-jisx0213-2      (font-spec :family "MS Gothic"))
(set-fontset-font nil 'katakana-jisx0201        (font-spec :family "MS Gothic"))
;; ラテン
(set-fontset-font nil 'latin-iso8859-1    (font-spec :family "Consolas"))
(set-fontset-font nil 'latin-iso8859-2    (font-spec :family "Consolas"))
(set-fontset-font nil 'latin-iso8859-3    (font-spec :family "Consolas"))
(set-fontset-font nil 'latin-iso8859-4    (font-spec :family "Consolas"))
(set-fontset-font nil 'cyrillic-iso8859-5 (font-spec :family "Consolas"))
(set-fontset-font nil 'greek-iso8859-7    (font-spec :family "Consolas"))

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
(setq case-fold-search nil)

;;; キーバインド
;; バッファ一覧を変更
(global-set-key "\C-x\C-b" 'bs-show)
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

;;; align
;; タブ位置で揃えない
(setq align-to-tab-stop nil)

;;; cua-mode
;; 矩形編集を有効にする
(cua-mode t)
(setq cua-enable-cua-keys nil)

;;; hl-line-mode
;; カーソル行を強調する
(global-hl-line-mode)

;;; verilog-mode
;; (eval-after-load "verilog-mode"
;;   '(progn
;;      ;; 基本設定
;;      (setq verilog-indent-level              4
;;            verilog-indent-level-module       4
;;            verilog-indent-level-declaration  4
;;            verilog-indent-declaration-macros nil
;;            verilog-indent-lists              t
;;            verilog-indent-level-behavioral   4
;;            verilog-indent-level-directive    4
;;            verilog-case-indent               4
;;            verilog-cexp-indent               4
;;            verilog-auto-newline              nil
;;            verilog-auto-indent-on-newline    t
;;            verilog-tab-always-indent         nil
;;            verilog-tab-to-comment            t
;;            verilog-auto-endcomments          t
;;            verilog-indent-begin-after-if     t
;;            verilog-align-ifelse              t
;;            verilog-auto-lineup               nil
;;            verilog-minimum-comment-distance  40
;;            verilog-highlight-p1800-keywords  t
;;            verilog-linter                    "verilator_bin --lint-only -Wall")
;;      ;; 数値リテラルのフェイス設定
;;      (font-lock-add-keywords
;;       'verilog-mode
;;       '(("\\(\\<[1-9][0-9_]*\\)?'h[0-9_a-fxz]+\\>" . font-lock-string-face)   ; 16進数
;;         ("\\(\\<[1-9][0-9_]*\\)?'d[0-9_xz]+\\>"    . font-lock-string-face)   ; 10進数
;;         ("\\(\\<[1-9][0-9_]*\\)?'o[0-7_xz]+\\>"    . font-lock-string-face)   ; 8進数
;;         ("\\(\\<[1-9][0-9_]*\\)?'b[01_xz]+\\>"     . font-lock-string-face)   ; 2進数
;;         ("\\<[0-9][0-9_]*\\>"                      . font-lock-string-face))) ; 基数なし
;;      ))

;;; vc
;; 無効にする
(setq vc-handled-backends nil)

;;; whitespace
;; 空白を強調する
(global-whitespace-mode)
;; 強調する空白を設定
(setq whitespace-style
      '(face
        trailing
        lines-tail
        empty
        space-after-tab
        space-before-tab
        space-mark
        tab-mark
        newline-mark))
;; 空白表示のマッピング
(setq whitespace-display-mappings
      '(
        (space-mark ?\u3000 [?﹏])
        (newline-mark ?\n [?↵ ?\n])
        (tab-mark ?\t [?\t ?⇥] [?\\ ?\t])))

;;; package.el管理パッケージの設定

;;; auto-complete
;; (require 'auto-complete-config)
;; ;; 辞書ディレクトリ指定
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/lisp/auto-complete/dict")
;; ;; 履歴ファイル指定
;; (setq ac-comphist-file "~/.emacs.d/lisp/auto-complete/history.txt")
;; ;; デフォルト設定
;; (ac-config-default)
;; ;; 1文字で補完を自動開始する
;; (setq ac-auto-start 1)
;; ;; コメント内や文字列内でも補完を有効にする
;; (setq ac-disable-faces nil)

(setq auto-mode-alist
      (append
       '(
         ("\\.c$"    . c-mode)
         ("\\.h$"    . c-mode)
         ("\\.java$" . java-mode)
         ("\\.c\\+\\+$" . c++-mode)
         ("\\.cpp$"  . c++-mode)
         ("\\.cc$"   . c++-mode)
         ("\\.hh$"   . c++-mode)
         )
       auto-mode-alist))

;;; cc-mode
(add-hook 'c-mode-common-hook
          (lambda ()
            ;; インデント設定
            (setq tab-width 4)
            (setq c-basic-offset 4)
            (c-set-offset 'arglist-intro '+)
            (c-set-offset 'arglist-close 0)
            (c-set-offset 'brace-list-open 0)
            (c-set-offset 'cpp-macro-cont '+)
            (c-set-offset 'substatement-open 0)
            ;; ドキュメントコメントのスタイル設定
            (setq c-doc-comment-style
                  '((c-mode   . javadoc)
                    (c++-mode . javadoc)))
            ))

;;; clang-format
(require 'clang-format)
(global-set-key [C-tab] 'clang-format-region)

;;; company
;; 全てのバッファで有効
(add-hook 'after-init-hook 'global-company-mode)
(with-eval-after-load 'company
  ;; Backendsにcompany-ironyを追加
  (add-to-list 'company-backends 'company-irony)
  ;; 補完開始までの時間
  (setq company-idle-delay 0.2)
  ;; 補完開始に必要な最低文字数
  (setq company-minimum-prefix-length 2)
  ;; 補完候補選択のラップアラウンドを有効
  (setq company-selection-wrap-around t)
  ;; 補完表示設定
  (custom-set-faces
   '(company-tooltip                  ((t (:inherit region                  ))))
   '(company-tooltip-selection        ((t (:background "brown"              ))))
   '(company-tooltip-search           ((t (:inherit isearch                 ))))
   '(company-tooltip-mouse            ((t (:inherit highlight               ))))
   '(company-tooltip-common           ((t (:inherit region     :underline t ))))
   '(company-tooltip-common-selection ((t (:background "brown" :underline t ))))
   '(company-tooltip-annotation       ((t (:inherit region                  ))))
   '(company-scrollbar-fg             ((t (:inherit default                 ))))
   '(company-scrollbar-bg             ((t (:inherit region                  ))))
   '(company-preview                  ((t (:inherit region                  ))))
   '(company-preview-common           ((t (:background "brown"              ))))
   '(company-preview-search           ((t (:inherit isearch                 ))))))

;;; flycheck
;; モード別設定
(add-hook 'c-mode-hook 'flycheck-mode)
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'emacs-lisp-mode 'flycheck-mode)
;; (add-hook 'verilog-mode 'flycheck-mode)
;; Verilogチェッカのverilatorの引数にverilog-library-filesを追加
;;(eval-after-load "flycheck"
;  '(progn
;     (flycheck-define-checker verilog-verilator
;       "A Verilog syntax checker using the Verilator Verilog HDL simulator."
;       :command ("verilator_bin" "--lint-only" "-Wall" (eval verilog-library-files) source)
;       :error-patterns ((warning line-start "%Warning-" (zero-or-more not-newline) ": " (file-name) ":" line ": " (message) line-end)
;                        (error line-start "%Error: " (file-name) ":" line ": " (message) line-end))
;       :modes (verilog-mode))
;     ))
(with-eval-after-load 'flycheck
  (require 'flycheck-irony)
  (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
  (flycheck-add-next-checker 'irony '(warning . c/c++-cppcheck)))

;;; helm
(require 'helm-config)
(helm-mode t)
(global-set-key (kbd "C-:") 'helm-mini)

;;; irony
;; モード設定
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'c++-mode-hook 'irony-mode)
;; Compilation Databaseから自動で設定を抽出
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
;; company-mode設定
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
;; キーバインド設定
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)

;;; multiple-cursors
;; キーバインド設定
(global-set-key (kbd "C-*") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)

;;; popwin
(require 'popwin)
(popwin-mode 1)
;; ウィンドウを下部に表示する
(setq popwin:popup-window-position 'bottom)
;; コンパイル結果ウィンドウを指定
(push '(compilation-mode :stick t) popwin:special-display-config)
;; Helmウィンドウを指定
(push '("helm" :regexp t) popwin:special-display-config)

;;; visual-regexp-steroids
(require 'visual-regexp-steroids)
;; 正規表現をPCREからElispに変換
(setq vr/engine 'pcre2el)
;; キーバインド設定: 標準の検索・置換
(global-set-key (kbd "C-M-s") 'vr/isearch-forward)
(global-set-key (kbd "C-M-r") 'vr/isearch-backward)
(global-set-key (kbd "C-M-%") 'vr/query-replace)
;; キーバインド設定: multiple-cursorsマーク
(global-set-key (kbd "C-c m") 'vr/mc-mark)

;;; yasnippet
;; モード設定
(add-hook 'c-mode-hook #'yas-minor-mode)
(add-hook 'c++-mode-hook #'yas-minor-mode)

;;; init.el ends here
