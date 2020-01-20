# GIT

# Configuring

<section>
Первоначальная настройка **Git**

```bash
git config --global user.name "Nikolay Rozhkov"
git config --global user.email rozhkov@uchi.ru
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

# INIT

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

<script src="highlight.min.js"></script>