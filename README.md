# Jan Trojak's Public Content

This repository contains all publicly available static content of Jan Trojak (blog, publications, main page, CV).

## Live Sites

* **Main Page:** [zezav.cz](https://zezav.cz)
* **Publications:** [pub.zezav.cz](https://pub.zezav.cz)
* **Blog:** [blog.zezav.cz](https://blog.zezav.cz)

## Usage

To build the content using Dagger, use the following commands:

### Pages
```bash
dagger call pages build-main-site export --path dist/zezav.cz
dagger call pages build-pub-site export --path dist/pub.zezav.cz
```

### Blog
```bash
dagger call blog build export --path dist/blog.zezav.cz
```

### Publications
```bash
dagger call pub build export --path dist/publications
```


## Publishing
```bash
dagger call publish --artifacts dist/zezav.cz --dest-path zezav.cz --server z01.de.zezav.cz --ssh-key file://~/.ssh/id_ed25519
dagger call publish --artifacts dist/pub.zezav.cz --dest-path pub.zezav.cz --server z01.de.zezav.cz --ssh-key file://~/.ssh/id_ed25519
dagger call publish --artifacts dist/publications --dest-path pub.zezav.cz/files --server z01.de.zezav.cz --ssh-key file://~/.ssh/id_ed25519
dagger call publish --artifacts dist/blog.zezav.cz --dest-path blog.zezav.cz --server z01.de.zezav.cz --ssh-key file://~/.ssh/id_ed25519
```
