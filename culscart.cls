% =============================================================================
%  culscart.cls — 全国大学生生命科学竞赛论文 LaTeX 模板
%  基础：ctexart + BibLaTeX (gb7714-2015) + unicode-math (XITS) + subcaption
% =============================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{culscart}[2026/05/30 v1.1 culsc article class]

% -------- 类选项 --------
%   header=true|false : 显示/关闭页眉文字与双线（默认关）
%   其他选项 → 透传到 ctexart
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=culscart, prefix=culscart@}
\DeclareBoolOption[false]{header}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessKeyvalOptions*

\LoadClass[UTF8,scheme=plain,fontset=none]{ctexart}

\RequirePackage{etoolbox}            % \AtBeginEnvironment / \AtEndEnvironment

% =============================================================================
%  §1  页面 / 版心 / 页眉 / 页脚
% =============================================================================
\RequirePackage[a4paper,left=2cm,right=2cm,top=2cm,bottom=2cm]{geometry}
% headheight 与 headsep 放在 geometry 之后用 \setlength 改：不参与
% \topmargin 计算，沿用 geometry 用默认值算出的 \topmargin。
% 两种 (headheight, headsep) 组合的总和都比默认 (12, 25) 多 5.76pt，
% body 位置在 header 开关之间保持一致。
\ifculscart@header
  \setlength{\headheight}{13pt}    % ≥ 12.80pt 避免 fancyhdr 警告
  \setlength{\headsep}   {29.76pt} % 13 + 29.76 = 42.76
\else
  \setlength{\headheight}{12pt}    % article 默认
  \setlength{\headsep}   {30.76pt} % 12 + 30.76 = 42.76
\fi

% 页眉/页脚：fancyhdr 接管
\RequirePackage{fancyhdr}
% 页眉字号：小五（9bp），紧凑 baseline 12pt 让一行落入 \headheight
\newcommand{\hdrfont}{\fontsize{9bp}{12bp}\selectfont}

% 通用 fancy 样式：页码 footer 总是开；header 内容只在 header=true 时显示
% \raisebox{-15.8pt}[0pt][0pt]{...}：文字视觉下移 15.8pt，[0pt][0pt] 声明 0
% 高 0 深，fancyhdr 不会因此抱怨；与 \headrule 里 \vskip15.8pt 同步。
\newcommand{\culsc@setupfancy}{%
  \fancyhf{}%
  \fancyfoot[C]{\wuhao -~\thepage~- }%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
  \ifculscart@header
    \fancyhead[L]{\hdrfont\raisebox{-15.8pt}[0pt][0pt]{第十一届全国大学生生命科学竞赛（科学探究类）}}%
    \fancyhead[R]{\hdrfont\raisebox{-15.8pt}[0pt][0pt]{论文}}%
    \renewcommand{\headrule}{%
      \vskip15.8pt%
      \hrule\@height1.5pt\@width\headwidth%
      \vskip1pt%
      \hrule\@height0.5pt\@width\headwidth%
      \vskip-18.8pt%
    }%
  \else
    \renewcommand{\headrule}{}%
  \fi
}

\pagestyle{fancy}
\culsc@setupfancy
\fancypagestyle{plain}{\culsc@setupfancy}

% =============================================================================
%  §2  段落 与 垂直间距 — 全部锁刚性，禁止 LaTeX 自动注入微小 glue
% =============================================================================
\RequirePackage{indentfirst}
\setlength{\parindent}    {2em}

\raggedbottom
\setlength{\parskip}      {0pt}
\setlength{\lineskip}     {0pt}
\setlength{\lineskiplimit}{0pt}
\setlength{\topskip}      {0pt}
\setlength{\partopsep}    {0pt}
\setlength{\topsep}       {0pt}
\setlength{\parsep}       {0pt}
\setlength{\itemsep}      {0pt}
\setlength{\footskip}     {26.4pt}

% 公式上下胶水改为刚性
\AtBeginDocument{%
  \abovedisplayskip      = 6pt\relax
  \belowdisplayskip      = 6pt\relax
  \abovedisplayshortskip = 0pt\relax
  \belowdisplayshortskip = 0pt\relax
}

% 句末不加额外 spacefactor
\frenchspacing

% multicol 加载时关栏底自动拉齐；未加载则跳过
\@ifpackageloaded{multicol}{\AtBeginDocument{\raggedcolumns}}{}

% =============================================================================
%  §3  字体
% =============================================================================
\RequirePackage{fontspec}
\setmainfont{Times New Roman}

% -------- 3.1 宋体（系统字体 → 项目 fonts/ttc → 项目 fonts/ttf） --------
\IfFontExistsTF{SimSun}{%
    \setCJKmainfont{SimSun}[AutoFakeBold=3, AutoFakeSlant=0.25]%
    \newfontfamily\simsun{SimSun}[AutoFakeBold=3, AutoFakeSlant=0.25]%
    \setCJKfamilyfont{songti}{SimSun}[AutoFakeBold=3, AutoFakeSlant=0.25]%
}{%
    \IfFileExists{fonts/simsun.ttc}{%
        \setCJKmainfont{simsun.ttc}[AutoFakeBold=3, AutoFakeSlant=0.25, Path=fonts/]%
        \newfontfamily\simsun{simsun.ttc}[AutoFakeBold=3, AutoFakeSlant=0.25, Path=fonts/]%
        \setCJKfamilyfont{songti}{simsun.ttc}[AutoFakeBold=3, AutoFakeSlant=0.25, Path=fonts/]%
    }{%
        \IfFileExists{fonts/simsun.ttf}{%
            \setCJKmainfont{simsun.ttf}[AutoFakeBold=3, AutoFakeSlant=0.25, Path=fonts/]%
            \newfontfamily\simsun{simsun.ttf}[AutoFakeBold=3, AutoFakeSlant=0.25, Path=fonts/]%
            \setCJKfamilyfont{songti}{simsun.ttf}[AutoFakeBold=3, AutoFakeSlant=0.25, Path=fonts/]%
        }{%
            \ClassWarning{culscart}{SimSun not found; using ctex default songti}%
            \newcommand{\simsun}{\rmfamily}%
        }%
    }%
}
\newcommand{\songti}{\CJKfamily{songti}}

% -------- 3.2 黑体 --------
% heiti CJK family 故意不带 AutoFakeBold：黑体本身已经够重，且让 \bfseries
% 在 \heiti 下作用于 Latin（TNR Bold）但保持 CJK 为 Heiti 常规字重 ——
% 用于一级标题"数字粗、中文不伪粗"的需求。需要伪粗体的场合改用 \simhei。
\IfFontExistsTF{SimHei}{%
    \setCJKfamilyfont{heiti}{SimHei}[BoldFont=SimHei, AutoFakeSlant=0.25]%
    \newfontfamily\simhei{SimHei}[AutoFakeBold=3, AutoFakeSlant=0.25]%
}{%
    \IfFileExists{fonts/simhei.ttc}{%
        \setCJKfamilyfont{heiti}{simhei.ttc}[BoldFont=simhei.ttc, AutoFakeSlant=0.25, Path=fonts/]%
        \newfontfamily\simhei{simhei.ttc}[AutoFakeBold=3, AutoFakeSlant=0.25, Path=fonts/]%
    }{%
        \IfFileExists{fonts/simhei.ttf}{%
            \setCJKfamilyfont{heiti}{simhei.ttf}[BoldFont=simhei.ttf, AutoFakeSlant=0.25, Path=fonts/]%
            \newfontfamily\simhei{simhei.ttf}[AutoFakeBold=3, AutoFakeSlant=0.25, Path=fonts/]%
        }{%
            \ClassWarning{culscart}{SimHei not found; using ctex default heiti}%
            \newcommand{\simhei}{\sffamily}%
        }%
    }%
}
\newcommand{\heiti}{\CJKfamily{heiti}}

% -------- 3.3 仿宋（兼作 mono CJK） --------
\setCJKfamilyfont{zhfs}{FangSong}
\providecommand{\fangsong}{}
\renewcommand {\fangsong}{\CJKfamily{zhfs}}
\setCJKmonofont{FangSong}

% -------- 3.4 数学字体 --------
\RequirePackage{unicode-math}
\setmathfont{XITS Math}[
    math-style   = ISO,
    bold-style   = ISO,
    StylisticSet = 8
]

% =============================================================================
%  §4  字号命令（行距统一 21.2275pt，对应第 11 届模板的每页 34 行 + 单倍行距）
% =============================================================================
\newcommand{\sihao}  {\fontsize{14bp}  {21.2275pt}\selectfont}  % 四号
\newcommand{\xiaosi} {\fontsize{12bp}  {21.2275pt}\selectfont}  % 小四
\newcommand{\wuhao}  {\fontsize{10.5bp}{21.2275pt}\selectfont}  % 五号
\newcommand{\xiaowu} {\fontsize{9bp}   {21.2275pt}\selectfont}  % 小五
\newcommand{\liuhao} {\fontsize{7.5bp} {21.2275pt}\selectfont}  % 六号

% 文档开始即切到正文五号
\AtBeginDocument{\wuhao}

% =============================================================================
%  §5  章节标题
%       一级：黑体 小四，前后零间距
%       二级：宋体加粗 小四，run-in，2em 接正文
%       三级：宋体加粗 五号，run-in，2em 接正文
%
%  关于 run-in：用 ctex 的 runin = true 而不是 \@startsection 负 afterskip：
%  后者只把光标回退 -parindent，标题宽度超过 parindent 时会与正文重叠；
%  ctex 的 runin 按标题实际宽度排版后再接 afterskip 水平间距。
%  注意必须把默认 aftertitle = \@@par 清空，否则即使 runin = true 标题
%  排完仍会强制 \par，把正文打到下一行。
% =============================================================================
\ctexset{
  section = {
    format     = \heiti\xiaosi\bfseries,   % \bfseries 只让 Latin/数字 → TNR Bold；
                                            % heiti family 无 AutoFakeBold，CJK 保持常规
    beforeskip = 0pt,
    afterskip  = 0pt,
  },
  subsection = {
    format     = \songti\bfseries\xiaosi,
    beforeskip = 0pt,
    afterskip  = 2em,
    runin      = true,
    aftertitle =,
  },
  subsubsection = {
    format     = \songti\bfseries\wuhao,
    beforeskip = 0pt,
    afterskip  = 2em,
    runin      = true,
    aftertitle =,
  },
  paragraph = {
    beforeskip = 0pt,
    afterskip  = 2em,
  },
}

% Run-in 标题的修补：runin 状态下，标题排版被挂在 \everypar 上等下一段
% 触发；若紧接着又来一个 sectioning 命令，它会直接覆盖 \everypar 丢失前
% 一个标题。这里在每个 sectioning 命令前 \leavevmode 强制触发挂起的标题、
% 再 \par 换行，实现"二级标题接三级标题时换行"的需求。
\newcommand{\sec@flushrunin}{%
  \if@noskipsec \leavevmode\par \fi}
\let\sec@origsection\section
\renewcommand{\section}{\sec@flushrunin\sec@origsection}
\let\sec@origsubsection\subsection
\renewcommand{\subsection}{\sec@flushrunin\sec@origsubsection}
\let\sec@origsubsubsection\subsubsection
\renewcommand{\subsubsection}{\sec@flushrunin\sec@origsubsubsection}

% =============================================================================
%  §6  图、子图、表
% =============================================================================
\RequirePackage{graphicx}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{booktabs}
\RequirePackage{array}

% -------- 6.1 caption 字体与 skip --------
\DeclareCaptionFont{capfont}{\liuhao}
\captionsetup{font=capfont,labelfont=capfont,labelsep=quad,%
              skip=0pt,aboveskip=0pt,belowskip=0pt}
\captionsetup[sub]{font=capfont,labelfont=capfont,labelformat=parens,labelsep=space,%
              skip=0pt,aboveskip=0pt,belowskip=0pt}
% 按浮动体类型分别覆盖（caption 在 \caption 触发时重写 \belowcaptionskip）
\captionsetup[figure]{belowskip=-15.96pt}
\captionsetup[table] {aboveskip=1.68pt,belowskip=-8.4pt}

% -------- 6.2 标签汉化 --------
\renewcommand{\figurename}{图}
\renewcommand{\tablename} {表}

% -------- 6.3 浮动体周围间距 --------
\setlength{\intextsep}   {11.5pt}   % [h] 浮动体上下
\setlength{\textfloatsep}{11.5pt}   % [t]/[b] 体与正文之间
\setlength{\floatsep}    {11.5pt}   % 同页两浮动体之间

% -------- 6.4 表内字号、行高与文字垂直居中 --------
% \liuhao 把 \baselineskip 设到 21.2275pt → \strutbox 高度 21.2275pt
% → 每行 \@arstrut 自动获得 21.2275pt 行高
% 默认 strut 是 .7/.3，baseline 在 cell 底起 30% 处，文字视觉中心偏下；
% 改成 .62/.38 把 baseline 抬到 38%，让 CJK + Latin 文字视觉居中
\AtBeginEnvironment{tabular}{%
  \liuhao
  \setbox\strutbox\hbox{%
    \vrule\@width\z@\@height.62\baselineskip\@depth.38\baselineskip}%
}
\renewcommand{\arraystretch}{1}

% -------- 6.5 booktabs：清掉 rule 上下 glue，调线宽 --------
\setlength{\aboverulesep}  {0pt}
\setlength{\belowrulesep}  {0pt}
\setlength{\extrarowheight}{0pt}    % array 包
\setlength{\heavyrulewidth}{1.5bp}  % \toprule / \bottomrule
\setlength{\lightrulewidth}{0.5bp}  % \midrule

% -------- 6.6 表浮动体下沿单独压窄 --------
% 在 \end{table} 之前注入一段不可丢弃负 vskip，
% 最终 \bottomrule → 下方正文距离 = \intextsep − 16.08pt
\AtEndEnvironment{table}{\vspace*{-16.08pt}}

% =============================================================================
%  §7  参考文献 (GB/T 7714-2015 顺序编码)
% =============================================================================
\RequirePackage[
  backend     = biber,
  style       = gb7714-2015,
  gbnamefmt   = lowercase
]{biblatex}

% 文献条目使用小五号
\renewcommand*{\bibfont}{\xiaowu}

% "参考文献" 标题：宋体 小五号 加粗
\defbibheading{cnref}[\refname]{%
  \par{\noindent\xiaowu\bfseries 参考文献}\vspace{-7.88pt}%
}

% =============================================================================
%  §8  超链接
% =============================================================================
\RequirePackage[hidelinks,unicode]{hyperref}

% =============================================================================
%  §9  题录块：\zhtitle / \entitle / \zhabstract / \zhkeywords + \maketitle
% =============================================================================
\newcommand{\zhtitle}   [1]{\gdef\@zhtitle{#1}}
\newcommand{\entitle}   [1]{\gdef\@entitle{#1}}
\newcommand{\zhabstract}[1]{\gdef\@zhabstract{#1}}
\newcommand{\zhkeywords}[1]{\gdef\@zhkeywords{#1}}
\gdef\@zhtitle{}\gdef\@entitle{}\gdef\@zhabstract{}\gdef\@zhkeywords{}

\renewcommand{\maketitle}{%
  \vspace*{-11.28pt}%
  \begin{center}
    {\heiti\sihao\@zhtitle\par}%
  \end{center}
  \vspace*{-1.68pt}%
  {\xiaowu\noindent\textbf{摘要：}\@zhabstract\par}%
  {\xiaowu\noindent\textbf{关键词：}\@zhkeywords\par}%
  \vspace*{1.68pt}%
  \begin{center}
    {\sihao\textbf{\@entitle}\par}%
  \end{center}
  \vspace*{-1.2pt}%
}

\endinput
