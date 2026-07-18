# roBa キーマップ

roBa(トラックボール付き左右分割キーボード)の現在のキーマップのドキュメント。キーマップ本体は [`config/roBa.keymap`](../../config/roBa.keymap) で定義している。

<img src="roBa.svg">

> この画像(`roBa.svg`)と `roBa.yaml` は [keymap-drawer](https://github.com/caksoylar/keymap-drawer) による自動生成物。更新方法は[後述](#キーマップ図の更新)。

## レイヤー構成

| # | 名前 | 発動方法 | 内容 |
|---|------|---------|------|
| 0 | default | ベース | QWERTY 配列 + IME 切り替え |
| 1 | FUNCTION | Enter(右親指)ホールド | F1〜F13 |
| 2 | NUM | Space(左親指)ホールド | 左手テンキー + 右手記号 |
| 3 | ARROW | 無変換(左親指)ホールド | 矢印・Home/End・タブ切り替え |
| 4 | MOUSE | トラックボール操作で自動有効化 | マウスボタン(MB1/MB2/MB3) |
| 5 | SCROLL | I キーホールド | トラックボールをスクロールに切り替え |
| 6 | layer_6 | 変換(左親指)ホールド | Bluetooth 管理・bootloader |

## デフォルトレイヤー(0)

- **配列**: QWERTY。US 配列前提
- **親指行(左)**: `Ctrl` / `Win(Cmd)` / `Alt` / `変換` / `Space` / `無変換`
- **親指行(右)**: `Backspace` / `Enter` / `Del`

### ホールド&タップキー

| キー | タップ | ホールド |
|------|--------|---------|
| 変換(左親指) | `INT_HENKAN` を送信してレイヤー0へ | レイヤー6(BT 管理) |
| Space(左親指) | `Space` | レイヤー2(NUM) |
| 無変換(左親指) | `INT_MUHENKAN` を送信してレイヤー0へ | レイヤー3(ARROW) |
| Enter(右親指) | `Enter` | レイヤー1(FUNCTION) |
| `Z` | `Z` | 左 Shift |
| `I` | `I` | レイヤー5(SCROLL) |

変換/無変換のタップは `lt_to_layer_0`(カスタム hold-tap)経由で、タップ時に必ずレイヤー0へ戻ってからキーを送信する。`&mt` は `flavor = "balanced"`、`quick-tap-ms = 0`、`tapping-term-ms` は 200ms。

### その他の特殊キー

- 左手内側(G の右): `Shift+Win+S`(Windows のスクリーンショット)
- 右手内側の縦列: `-` / `;`(上から)

## コンボ(同時押し)

| キー | 出力 |
|------|------|
| A + S | 無変換(`INT_MUHENKAN` + レイヤー0へ) |
| S + D | `Tab` |
| D + F | `Shift+Tab` |
| L + `'` | `"` |
| C + V | `=` |

## 各レイヤーの詳細

### 1: FUNCTION

右手側に F1〜F12 を配置。右手内側上段に `F13`。

### 2: NUM

左手にテンキー(`KP_0`〜`KP_9`、四則演算)、右手に記号(`^ & ~ ( ) _ ! @ # $ % [ ] { } \ |`)。`KP_0` はホールドで左 Shift。左手内側に `Ctrl+Alt+KP_0`。

### 3: ARROW

- 左手ホームポジションに `←↓→` + `Home`/`End`、上段に `↑`
- `Ctrl+Tab` / `Ctrl+Shift+Tab`(タブ切り替え)、`Esc`
- `Win+Shift+←` / `Win+Shift+→`(下段)
- ロータリーエンコーダ: `Ctrl+PgUp` / `Ctrl+PgDn`(デフォルトレイヤーでは `PgUp` / `PgDn`)

### 4: MOUSE(自動マウスレイヤー)

トラックボールを動かすと自動で有効になる(`automouse-layer = <4>`、タイムアウト 700ms)。右手ホームポジションに `左クリック(J)` / `中クリック(K)` / `右クリック(L)`。

### 5: SCROLL

このレイヤーが有効な間、トラックボールの移動がスクロールになる(`scroll-layers = <5>`)。キー割り当てはすべて透過。

### 6: layer_6(Bluetooth 管理)

- 右手上段: BT プロファイル 0〜4 の選択
- `P` 位置下段: `BT_CLR`(現在のプロファイル削除)、右下: `BT_CLR_ALL`(全削除)
- 右手内側: `&bootloader`(ファームウェア書き込みモード)
- 左手下段: `1` `2` `3`(通常の数字キー)

## トラックボール(PMW3610)

センサー設定は [`boards/shields/roBa/roBa_R.conf`](../../boards/shields/roBa/roBa_R.conf) で定義。主な設定:

- CPI 400、ポーリングレート 125Hz(ソフトウェア)
- 自動マウスレイヤーのタイムアウト 700ms
- スクロール刻み 16、スクロール X 軸反転
- スマートアルゴリズム有効

## キーマップ図の更新

`roBa.svg` / `roBa.yaml` は GitHub Actions の [Draw Keymap ワークフロー](../../.github/workflows/draw.yml)で自動生成される(出力先: `docs/keymap/`)。

現在は push による自動実行はコメントアウトされているため、キーマップ変更後は Actions タブから **Draw Keymap** を手動実行(workflow_dispatch)する。
