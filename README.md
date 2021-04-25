# reporter
rmarkdown, latex, pandoc toolchains with fonts for document generation

## generating a document from the command line with docker compose

The most convenient way to use this image is with docker compose. Using a `docker-compose.yml` file similar to the example here, you can run `docker-compose run generate foo.Rmd`
and the docker image will be downloaded, map your working directory into the container, and run the RStudio/RMarkdown toolchain to generate your document. The output will
have the same basename as the input, but the output filetype will be based on what you have configured in your RMarkdown frontmatter.

```yaml
version: '2'
services:
  generate:
    image: ghcr.io/kindlyops/reporter:v1.1.0
    working_dir: /docs
    volumes:
      - .:/docs
    command:
      - my-markdown-document.Rmd
```

## wrapper utility script

If you need to process ad hoc RMarkdown files it can be handy to use a wrapper script instead of needing to remember a long docker command or keep making docker-compose config files.

```bash
#!/usr/bin/env bash
# put this in a file named rmarkdown
exec docker run -t --volume "$(pwd)":/docs -w /docs ghcr.io/kindlyops/reporter:v1.1.0 "$@"
```
Now you can run commands like `rmarkdown foo.Rmd` and get the file processed right away.
