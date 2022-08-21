---
title: "Getting Started"
disqus: ""
---

# Welcome to Eng Learning Site

欢迎大家来到我的Learning Site！首先感谢 {++mkdocs-material++} 为我们提供这么棒的主题。

我在这里贴出来我的网站这个主题的配置文件 mkdocs.yml：

```yaml
# Site Information
site_name: <site-name>
site_description: <site_description>
site_author: <author_name>
site_url: https://yongqilei.github.io

# Repository
repo_name: 'Programming Space'
repo_url: https://github.com/yongqilei/yongqilei.github.io

# Copyright
copyright: 'Copyright &copy; 2021 - 2022 Eng Learning by Torres'

# Contents
nav:
  - intro: ...


# Plugins
plugins:
  - search

# Theme
theme:
  name: null
  language: zh
  custom_dir: 'mkdocs-material/material'
  static_templates:
    - 404.html
  include_search_page: false
  search_index_only: true
  palette:
    - sheme: default
      primary: indigo
      accent: indigo
      toggle:
        icon: material/toggle-switch
        name: Switch to dark mode
    - scheme: slate
      primary: red
      accent: red
      toggle:
        icon: material/toggle-switch-off-outline
        name: Switch to light mode
  font:
    text: 'Fira Sans'
    code: 'Fira Mono'
  features:
    - search.suggest
    - search.highlight
    - search.share
    - navigation.tabs
    - navigation.instant
    - navigation.tracking
    - navigation.top
    - content.tabs.link
  icon:
    repo: fontawesome/brands/github-alt
    logo: material/book-education-outline
    admonition:
      note: octicons/tag-16
      abstract: octicons/checklist-16
      info: octicons/info-16
      tip: octicons/squirrel-16
      success: octicons/check-16
      question: octicons/question-16
      warning: octicons/alert-16
      failure: octicons/x-circle-16
      danger: octicons/zap-16
      bug: octicons/bug-16
      example: octicons/beaker-16
      quote: octicons/quote-16
  favicon: 'favicon.ico'

extra:
  disqus: <disqus-shortname>

# Extensions
markdown_extensions:
  - admonition
  - codehilite:
      guess_lang: false
      linenums: true
  - def_list
  - footnotes
  - meta
  - toc:
      permalink: true
  - pymdownx.arithmatex
  - pymdownx.caret
  - pymdownx.critic
  - pymdownx.details
  - pymdownx.emoji:
      emoji_generator: !!python/name:pymdownx.emoji.to_svg
  - pymdownx.highlight:
      linenums: true
  - pymdownx.inlinehilite
  - pymdownx.keys
  - pymdownx.magiclink
  - pymdownx.mark
  - pymdownx.snippets
  - pymdownx.progressbar
  - pymdownx.smartsymbols
  - pymdownx.superfences:
      custom_fences:
        - name: mermaid
          class: mermaid
          format: !!python/name:pymdownx.superfences.fence_code_format
  - pymdownx.tasklist:
      custom_checkbox: true
  - pymdownx.tilde
  - pymdownx.tabbed:
      alternate_style: true 
```

如果有什么我写的不对的地方，请大家指出来并report到issues中。