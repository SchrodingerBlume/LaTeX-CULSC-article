# culscart

全国大学生生命科学竞赛（科学探究类）论文 LaTeX 模板。

## 编译

```bash
xelatex main
biber   main
xelatex main
xelatex main
```

引擎必须用 **XeLaTeX**，文献后端用 **biber**。

## 依赖

TeX Live 2023 或更新版本，需包含：

- `ctex`
- `fontspec` / `unicode-math`
- `biblatex` + `biblatex-gb7714-2015` + `biber`
- `fancyhdr` / `caption` / `subcaption` / `booktabs`

字体：

- Times New Roman、SimSun（宋体）、SimHei（黑体）、FangSong（仿宋）—— 系统未装时模板会回退到项目目录下 `fonts/simsun.{ttc,ttf}` / `simhei.{ttc,ttf}`
- XITS Math（TeX Live 自带）

## 选项

```latex
\documentclass{culscart}              % 不显示页眉（默认）
\documentclass[header=true]{culscart} % 显示页眉文字与双线
```
