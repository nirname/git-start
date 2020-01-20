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

## Doing chagnes

```shell
git add .
git reset -- dont-commit.txt
git commit -m 'Here goes message'
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

# Branches

<section>
Создание ветки

```shell
git branch feature
```

Переключение

```shell
git checkout feature
```

Сокращённо

```bash
git checkout -b feature
```
</section>

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

<script src="highlight.min.js"></script>