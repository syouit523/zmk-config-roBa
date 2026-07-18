# キーマップ図(docs/keymap/roBa.svg)をローカルで生成する
#
#   make draw   … config/roBa.keymap から SVG を再生成
#   make clean  … venv と生成物のキャッシュを削除
#
# 初回実行時に .venv/ を作成して keymap-drawer を自動インストールする。
# CI (.github/workflows/draw.yml) と同じ keymap-drawer を使うため出力は同等。

VENV        := .venv
KEYMAP_CLI  := $(VENV)/bin/keymap

KEYMAP_SRC  := config/roBa.keymap
LAYOUT_JSON := config/roBa.json
OUT_DIR     := docs/keymap
YAML        := $(OUT_DIR)/roBa.yaml
SVG         := $(OUT_DIR)/roBa.svg

.PHONY: draw clean

draw: $(SVG)

$(KEYMAP_CLI):
	python3 -m venv $(VENV)
	$(VENV)/bin/pip install --quiet keymap-drawer

$(YAML): $(KEYMAP_SRC) | $(KEYMAP_CLI)
	$(KEYMAP_CLI) parse -z $(KEYMAP_SRC) > $@

$(SVG): $(YAML) $(LAYOUT_JSON) | $(KEYMAP_CLI)
	$(KEYMAP_CLI) draw -j $(LAYOUT_JSON) $(YAML) > $@

clean:
	rm -rf $(VENV)
