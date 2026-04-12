# 个人配置变更记录

记录对上游 [ayamir/nvimdots](https://github.com/ayamir/nvimdots) 的自定义修改，以便跟踪和回溯。

---

## 2026-04-10

### 插件替换

#### Comment.nvim → ts-comments.nvim

- 移除 `numToStr/Comment.nvim` 和 `JoosepAlviste/nvim-ts-context-commentstring`
- 添加 `folke/ts-comments.nvim`（自动支持 treesitter 语言感知注释）
- 删除 `lua/modules/configs/editor/comment.lua` 和 `lua/modules/configs/editor/ts-context-commentstring.lua`
- 清理 `lua/keymap/editor.lua` 中所有 `<Plug>(comment_toggle_*)` 绑定

#### LunarVim/bigfile.nvim → snacks.bigfile

- 移除 `LunarVim/bigfile.nvim` 插件声明及其配置文件
- 在 `lua/user/configs/editor/snacks.lua` 中启用 `bigfile`，保持 1MB 阈值
- `lua/modules/configs/editor/treesitter.lua` 大文件检测改为 `vim.b[bufnr].bigfile == true`

#### ojroques/nvim-bufdel → snacks.bufdelete

- 移除 `ojroques/nvim-bufdel` 插件声明
- `<A-q>` 改为调用 `Snacks.bufdelete()`
- `lua/modules/configs/ui/bufferline.lua` 的 `close_command` 改为函数形式

#### ahmedkhalf/project.nvim → 移除

- 移除插件声明及 `lua/modules/configs/tool/project.lua`
- 移除 telescope 中的 `load_extension("projects")`
- `<leader>fp` 和 alpha 启动页改为 `find_files({ cwd = vim.fn.getcwd() })`

#### iamcco/markdown-preview.nvim → 移除

- 移除插件声明
- 移除 `<F12>` MarkdownPreviewToggle 绑定

#### lukas-reineke/cmp-under-comparator → 移除

- 移除插件声明
- 从 `lua/modules/configs/completion/cmp.lua` 中移除两处 `require("cmp-under-comparator").under`

### 功能变更

#### lazygit 触发方式：toggleterm → snacks.lazygit

- 在 `lua/user/configs/editor/snacks.lua` 中启用 `lazygit`
- `<leader>gg` 改为调用 `Snacks.lazygit()`

### 接口迁移

#### trouble.nvim v1 → v3

`trouble.nvim` 在 v3 进行了完整重写，API 不兼容，已完成迁移：

**`lua/modules/configs/tool/trouble.lua`**

| 旧配置                      | 新配置                                   |
| --------------------------- | ---------------------------------------- |
| `position`                  | `win.position`                           |
| `height` / `width`          | `win.size.height` / `win.size.width`     |
| `action_keys`               | `keys`（key 名称格式改变）               |
| `fold_open` / `fold_closed` | `icons.indent.fold_open` / `fold_closed` |
| `signs`                     | 已移除                                   |
| `use_diagnostic_signs`      | 已移除                                   |
| `mode`（顶层）              | 通过命令参数指定                         |
| `auto_jump`                 | 移入 `modes.<mode>.auto_jump`            |

**`lua/keymap/tool.lua`**

| 按键         | 旧命令                                | 新命令                                    |
| ------------ | ------------------------------------- | ----------------------------------------- |
| `gt`         | `TroubleToggle`                       | `Trouble diagnostics toggle`              |
| `<leader>ll` | `TroubleToggle lsp_references`        | `Trouble lsp_references toggle`           |
| `<leader>ld` | `TroubleToggle document_diagnostics`  | `Trouble diagnostics toggle filter.buf=0` |
| `<leader>lw` | `TroubleToggle workspace_diagnostics` | `Trouble diagnostics toggle`              |
| `<leader>lq` | `TroubleToggle quickfix`              | `Trouble qflist toggle`                   |
| `<leader>lL` | `TroubleToggle loclist`               | `Trouble loclist toggle`                  |

**`lua/modules/plugins/tool.lua`**

- `cmd` 列表中移除已废弃的 `TroubleToggle` 和 `TroubleRefresh`，仅保留 `Trouble`

---

## 2026-04-13

### 功能变更

#### 启用 snacks.words

- 在 `lua/user/configs/editor/snacks.lua` 中添加 `words = { enabled = true }`
- 自动高亮光标下的同名单词（基于 LSP references）
- 默认快捷键：
  - `]]` — 跳转到下一个引用
  - `[[` — 跳转到上一个引用

#### 启用 snacks.quickfile

- 在 `lua/user/configs/editor/snacks.lua` 中添加 `quickfile = { enabled = true }`
- 执行 `nvim somefile` 时，在插件加载完成前提前渲染文件内容和语法高亮，减少视觉白屏等待
- 无需额外配置，开启即生效

#### 启用 snacks.scope

- 在 `lua/user/configs/editor/snacks.lua` 中添加 `scope = { enabled = true }`
- 基于 treesitter（或回退到缩进）检测光标所在的代码块范围（函数、if、for 等）
- 默认快捷键：
  - `[i` — 跳转到当前作用域的上边界
  - `]i` — 跳转到当前作用域的下边界
- 文本对象（可配合 `v`/`d`/`y` 使用）：
  - `ii` — 选中内层作用域（不含边界行）
  - `ai` — 选中完整作用域（含边界行）

#### 启用 snacks.scroll

- 在 `lua/user/configs/editor/snacks.lua` 中添加 `scroll = { enabled = true }`
- 为 `<C-d>`、`<C-u>`、`<C-f>`、`<C-b>` 等翻页操作添加平滑动画过渡，避免视图瞬间跳动
- 同时支持鼠标滚轮平滑滚动，正确处理 `scrolloff`
- 如需在某个 buffer 中禁用：`vim.b.snacks_scroll = false`

#### 启用 snacks.statuscolumn

- 在 `lua/user/configs/editor/snacks.lua` 中添加 `statuscolumn = { enabled = true }`
- 接管 nvim 左侧状态列，统一管理各类图标的显示顺序，解决多插件争抢 signcolumn 导致的错位问题
- 默认布局：
  - 左侧（高优先级到低）：`mark`（书签）、`sign`（诊断图标）
  - 右侧（高优先级到低）：`fold`（折叠）、`git`（git 变更标记）
