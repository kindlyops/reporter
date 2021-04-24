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
    image: ghcr.io/kindlyops/reporter:v1.0.1
    working_dir: /docs
    volumes:
      - .:/docs
    command:
      - my-markdown-document.Rmd
```
