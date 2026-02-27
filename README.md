# Jan Trojak's Public Content

This repository contains all publicly available static content of Jan Trojak (blog, publications, main page, CV).

## Live Sites

* **Main Page:** [zezav.cz](https://zezav.cz)
* **Blog:** [blog.zezav.cz](https://blog.zezav.cz)

## Usage

To build the content using Dagger, use the following commands:

### Pages
```bash
dagger call pages build-main-site export --path dist/zezav.cz
```

### Blog
```bash
dagger call blog build export --path dist/blog.zezav.cz
```

### Publications
```bash
dagger call pub build export --path dist/publications
```
