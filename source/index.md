# GIT

# Configuring

<section>
Первоначальная настройка **Git**

```bash
git config --global user.name "Inanov Ivan"
git config --global user.email ivanov@example.com
```
</section>

<section>

.gitconfig
```ini
[alias]
  l = log --pretty=format:\"%C(yellow)%h%C(reset) | %s %C(red)[%aN]%C(green)%d%C(reset)\" --decorate --graph --all
  co = checkout
  ci = commit
  st = status
  br = branch
  mr = merge
```
</section>

<section>
Внешние утилиты

```bash
git config --global diff.tool meld
git config --global difftool.prompt false
git config --global core.editor /usr/bin/vim
```
</section>

<section>
External **diff**

```ini
[diff]
  tool = meld
[difftool]
  path = meld
  prompt = false
```
External **editor**

```ini
[core]
  editor = /usr/bin/vim
```
</section>

# Init

<section>
Инициализировать новый проект c **Git**

```bash
git init new-project
```

Добавить существующий проект в **Git**

```bash
cd existing-project
git init .
```
</section>

# Staging

<section>
```seqdiag
seqdiag {
  activation = none
  dir [label="Working\ndirectory", color="#F1A340", fontsize=14]
  index [label="Index", fontsize=14]
  repo [label="Repository", color="#998DC3", fontsize=14]

  dir <- repo [label="checkout", fontsize=14]
  dir -> index [label="add", fontsize=14]
  dir <- index [label="reset", fontsize=14]
  index -> repo [label="commit", fontsize=14]

}
```
</section>

<section>
Внесение изменений

```shell
git add .
git reset -- dont-commit.txt
git commit -m 'Here goes message'
```
</section>

# Branches

<section>
Список веток

```bash
$ git branch --all
* master
```

```dot
digraph {
  graph[ splines=false fontname="Arial" bgcolor="transparent" rankdir=LR]
  node [style="filled" fontcolor="white" fontsize=20]

  subgraph nodes {
    node [shape="circle" color="#e66101" fillcolor="#e66101"]
    A B C
  }

  { A -> B -> C }

  {
    node [shape="rect" color="#4dac26" fillcolor="#4dac26"]
    head
  }

  {
    node [shape="rect" color="#0571b0" fillcolor="#0571b0"]
    master
  }

 {
    rank = same
    C -> master -> head [dir="back"]
  }
}
```
</section>

<section>
Новая ветка
```bash
git branch feature
git checkout feature
git checkout -b feature # сокращённо
```


```dot
digraph {
  graph[ splines=false fontname="Arial" bgcolor="transparent" rankdir=LR]
  node [style="filled" fontcolor="white" fontsize=20]

  subgraph nodes {
    node [shape="circle" color="#e66101" fillcolor="#e66101"]
    A B C
  }

  { A -> B -> C }

  {
    node [shape="rect" color="#4dac26" fillcolor="#4dac26"]
    head
  }

  {
    node [shape="rect" color="#0571b0" fillcolor="#0571b0"]
    master feature
  }

 {
    rank = same
    C -> master [dir="back"]
  }

  {
    rank = same
    head -> feature -> C
  }

}
```
</section>

<section>
Разработка

```bash
touch D; git add .; git commit -m 'D'
touch F; git add .; git commit -m 'F'
```

```dot
digraph {
  graph[ splines=false fontname="Arial" bgcolor="transparent" rankdir=LR]
  node [style="filled" fontcolor="white" fontsize=20]

  subgraph nodes {
    node [shape="circle"]
    {
      node [color="#e66101" fillcolor="#e66101"]
      A B C
    }
    {
      node [color="#5e3c99" fillcolor="#5e3c99"]
      D E
    }
  }

  { A -> B -> C -> D -> E }

  {
    node [shape="rect" color="#4dac26" fillcolor="#4dac26"]
    head
  }

  {
    node [shape="rect" color="#0571b0" fillcolor="#0571b0"]
    master feature
  }

 {
    rank = same
    C -> master [dir="back"]
  }

  {
    rank = same
    head -> feature -> E
  }
}
```
</section>

<section>
Слияние **fast-forward, "Перемотка"**

```bash
git checkout master
git merge feature
```

```dot
digraph {
  graph[ splines=false fontname="Arial" bgcolor="transparent" rankdir=LR]
  node [style="filled" fontcolor="white" fontsize=20]

  subgraph nodes {
    node [shape="circle" color="#e66101" fillcolor="#e66101"]
    {
      node [color="#e66101" fillcolor="#e66101"]
      A B C
    }
    {
      node [color="#5e3c99" fillcolor="#5e3c99"]
      D E
    }
  }

  { A -> B -> C }
  { C -> D -> E }

  {
    node [shape="rect" color="#4dac26" fillcolor="#4dac26"]
    head
  }

  {
    node [shape="rect" color="#0571b0" fillcolor="#0571b0"]
    master feature
  }

  {
    rank = same
    feature -> E
    E -> master -> head [dir = "back"]
  }
}
```
</section>

<section>
Слияние **--no-ff**

```bash
git checkout master
git merge --no-ff feature
```

```dot
digraph {
  graph[ splines=false fontname="Arial" bgcolor="transparent" rankdir=LR]
  node [style="filled" fontcolor="white" fontsize=20]

  subgraph nodes {
    node [shape="circle"]
    {
      node [color="#e66101" fillcolor="#e66101"]
      A B C
    }
    {
      node [color="#5e3c99" fillcolor="#5e3c99"]
      D E
    }
    {
      node [color="#e66101" fillcolor="#e66101"]
      F
    }
  }

  { A -> B -> C -> F }
  { C -> D -> E -> F }

  {
    node [shape="rect" color="#4dac26" fillcolor="#4dac26"]
    head
  }

  {
    node [shape="rect" color="#0571b0" fillcolor="#0571b0"]
    master feature
  }

  {
    rank = same
    F -> master -> head [dir="back"]
  }

  {
    rank = same
    feature -> E
  }
}
```
</section>

<section>
Слияние при наличии других коммитов

```dot
digraph {
  graph[ splines=false fontname="Arial" bgcolor="transparent" rankdir=LR]
  node [style="filled" fontcolor="white" fontsize=20]

  subgraph nodes {
    node [shape="circle"]
    {
      node [color="#e66101" fillcolor="#e66101"]
      A B C
    }
    {
      node [color="#5e3c99" fillcolor="#5e3c99"]
      D E
    }
    {
      node [color="#018571" fillcolor="#018571"]
      G
    }
    {
      node [color="#e66101" fillcolor="#e66101"]
      F
    }
  }

  { A -> B -> C -> G -> F }
  { C -> D -> E -> F }

  {
    node [shape="rect" color="#4dac26" fillcolor="#4dac26"]
    HEAD
  }

  {
    node [shape="rect" color="#0571b0" fillcolor="#0571b0"]
    master feature
  }

  {
    rank = same
    G D
  }

  {
    rank = same
    F -> master -> HEAD [dir="back"]
  }

  {
    rank = same
    feature -> E
  }
}
```
</section>

# Discarding

<section>
Целый commit


```bash
git revert head~1
git revert b
```

```dot
digraph {
  graph[splines=false fontname="Arial" bgcolor="transparent" rankdir=LR]
  node [style="filled" fontcolor="white" fontsize=20]

  subgraph nodes {
    node [shape="circle"]
    {
      node [color="#e66101" fillcolor="#e66101"]
      A C
    }
    {
      node [color="#5e3c99" fillcolor="#5e3c99"]
      B
    }
    {
      node [color="#5e3c99" penwidth=2 fontcolor="#5e3c99" fillcolor="#5e3c99" style=dashed]
      "-B"
    }
  }

  subgraph labels {
    node [shape="rect"]
    {
      node[color="#4dac26" fillcolor="#4dac26"]
      head
    }
    {
      node[color="#4dac26" fillcolor="#4dac26" fontcolor="#4dac26" fillcolor="#4dac26" style=dashed penwidth=2]
      "head'"
    }
    {
      node[color="#0571b0" fillcolor="#0571b0"]
      feature
    }
    {
      node[color="#0571b0" fillcolor="#0571b0" fontcolor="#0571b0" fillcolor="#0571b0" style=dashed penwidth=2]
      "feature'"
    }
  }

  A -> B -> C -> "-B"
  // B:ne -> "-B":nw [style="dashed"]

  {
    rank = same
    C -> feature -> head [dir=back]
  }

  {
    rank = same
    "-B" -> "feature'" -> "head'" [dir=back]
  }

}
```
</section>

<section>
1 файл

```bash
git reset b -- main.cpp;            git ci -m 'main.cpp - b'
git co    b -- main.cpp; git add .; git ci -m 'main.cpp - b'
```

```dot
digraph {
  graph[splines=true fontname="Arial" bgcolor="transparent" rankdir=LR]
  node [shape="rect" style="filled" fontcolor="white" fontsize=20]
  subgraph cluster_a {
    node [fillcolor="#db2b39" color="#db2b39"]
    label="A"
    a_main_cpp [label="main.cpp"]
    a_main_h [label="main.h"]
  }
  subgraph cluster_b {
    node [fillcolor="#29335c" color="#29335c" fontcolor="white"]
    label="B"
    b_main_cpp [label="main.cpp"]
    b_main_h [label="main.h"]
  }
  subgraph cluster_c {
    node [fillcolor="#f4a711" color="#f4a711"]
    label="C"
    c_main_cpp [label="main.cpp"]
    c_main_h [label="main.h"]
  }
  subgraph cluster_d {
    label="D"
    d_main_cpp [label="main.cpp" fillcolor="#29335c" color="#29335c" fontcolor="white"]
    d_main_h [label="main.h" fillcolor="#f4a711" color="#f4a711"]
  }

  a_main_cpp -> b_main_cpp -> c_main_cpp
  b_main_cpp -> d_main_cpp [style="dashed"]
  a_main_h -> b_main_h -> c_main_h -> d_main_h

}
```
</section>


<section>
```seqdiag
seqdiag {
  activation = none
  dir [label="Working\ndirectory", color="#F1A340", fontsize=14]
  index [label="Index", fontsize=14]
  repo [label="Repository", color="#998DC3", fontsize=14]

  repo -> repo [label="reset --soft", fontsize=14]
  index <- repo [label="reset [--mixed]", fontsize=14]
  dir <- index [label="reset --hard", fontsize=14]
}
```
</section>

<section>
Revisions

**master**

<p class="fragment">
**v1**
</p>

<p class="fragment">
**b1713c7**
</p>

</section>

<section>
Revisions

<p class="fragment">
HEAD**^**
</p>

<p class="fragment">
HEAD**~**
</p>

<p class="fragment">
HEAD**@{**0**}**
</p>
</section>

# Remotes

<section>

```
git init project && cd ..
```

<pre><code class="hljs nohighlight">git clone project<span class="fragment fade-up" data-fragment-index="0" style="color: #4dac26;"> -o source</span> local
cd local<span class="fragment fade-up" data-fragment-index="1" style="color: #5e3c99"> && git branch -m main</span>
<span class="fragment fade-out" data-fragment-index="3"><span class="fragment fade-up" data-fragment-index="2" style="color: #e66101">git branch --unset-upstream</span></span><span class="fragment fade-up" data-fragment-index="3" style="color: #0571b0">git branch --set-upstream-to=source/master</span>
cat .git/config</code></pre>

<pre><code class="hljs nohighlight">[remote "<span class="fragment fade-out" data-fragment-index="0">origin</span><span class="fragment fade-up" data-fragment-index="0" style="color: #4dac26;">source</span>"]
  url = /tmp/project
  fetch = +refs/heads/*:refs/remotes/<span class="fragment fade-out" data-fragment-index="0">origin</span><span class="fragment fade-up" data-fragment-index="0" style="color: #4dac26;">source</span>/*
[branch "<span class="fragment fade-out" data-fragment-index="1">master</span><span class="fragment fade-up" data-fragment-index="1" style="color: #5e3c99">main</span>"]
  <span class="fragment fade-out" data-fragment-index="2">remote = <span class="fragment fade-out" data-fragment-index="0">origin</span><span class="fragment fade-up" data-fragment-index="0" style="color: #4dac26;">source</span>
  merge = refs/heads/master</span><span class="fragment fade-up" data-fragment-index="3" style="color: #0571b0">remote = source
  merge = refs/heads/master</span></span></code></pre>

</section>


<section>
```dot
digraph {
  graph[bgcolor="transparent" rankdir=LR]
  node [style="filled" fontcolor="white" fontsize=20]

  {
    node[shape="circle" fillcolor="#e66101"]
    A -> B
  }

  {
    node[shape="rect" fillcolor="#0571b0"]
    rank="same"
    master -> B
  }
}
```
</section>


<section>


## Undoing changes

**Unstage changes**
```shell
git reset --soft
```

**Save staged changes**
```shell
git reset
```

</section>