FROM  havengrc-docker.jfrog.io/rocker/rstudio:4.0.4
LABEL maintainer="Kindly Ops, LLC <support@kindlyops.com>"
LABEL org.opencontainers.image.source="https://github.com/statik/resume"

ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -f -y --no-install-recommends \
    curl apt-utils ca-certificates zlib1g-dev libproj-dev xzdec gnupg fontconfig \
    libxml2-dev rsync \
    biber \
    cm-super \
    dvipng \
    ghostscript \
    gnuplot \
    make \
    latex-cjk-all \
    latex-cjk-common \
    latex-cjk-chinese \
    latexmk \
    lcdf-typetools \
    lmodern \
    poppler-utils \
    psutils \
    purifyeps \
    python3-pygments \
    t1utils \
    tex-gyre \
    tex4ht \
    texlive-base \
    texlive-bibtex-extra \
    texlive-binaries \
    texlive-extra-utils \
    texlive-font-utils \
    texlive-fonts-extra \
    texlive-fonts-extra-links \
    texlive-fonts-recommended \
    texlive-formats-extra \
    texlive-lang-all \
    texlive-lang-chinese \
    texlive-lang-cjk \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-latex-recommended \
    texlive-luatex \
    texlive-metapost \
    texlive-pictures \
    texlive-plain-generic \
    texlive-pstricks \
    texlive-publishers \
    texlive-science \
    texlive-xetex \
    texlive-bibtex-extra &&\
    # delete Tex Live sources and other potentially useless stuff
    echo "Delete TeX Live sources and other useless stuff." &&\
    (rm -rf /usr/share/texmf/source || true) &&\
    (rm -rf /usr/share/texlive/texmf-dist/source || true) &&\
    find /usr/share/texlive -type f -name "readme*.*" -delete &&\
    find /usr/share/texlive -type f -name "README*.*" -delete &&\
    (rm -rf /usr/share/texlive/release-texlive.txt || true) &&\
    (rm -rf /usr/share/texlive/doc.html || true) &&\
    (rm -rf /usr/share/texlive/index.html || true)
    # clean up all temporary files
    # echo "Clean up all temporary files." &&\
    # apt-get clean -y &&\
    # rm -rf /var/lib/apt/lists/* &&\
    # rm -f /etc/ssh/ssh_host_* &&\
    # # delete man pages and documentation
    # echo "Delete man pages and documentation." &&\
    # rm -rf /usr/share/man &&\
    # mkdir -p /usr/share/man &&\
    # find /usr/share/doc -depth -type f ! -name copyright -delete &&\
    # find /usr/share/doc -type f -name "*.pdf" -delete &&\
    # find /usr/share/doc -type f -name "*.gz" -delete &&\
    # find /usr/share/doc -type f -name "*.tex" -delete &&\
    # (find /usr/share/doc -type d -empty -delete || true) &&\
    # mkdir -p /usr/share/doc &&\
    # rm -rf /var/cache/apt/archives &&\
    # mkdir -p /var/cache/apt/archives &&\
    # rm -rf /tmp/* /var/tmp/* &&\
    # (find /usr/share/ -type f -empty -delete || true) &&\
    # (find /usr/share/ -type d -empty -delete || true) &&\
    # mkdir -p /usr/share/texmf/source &&\
    # mkdir -p /usr/share/texlive/texmf-dist/source

RUN apt-get install -f -y --no-install-recommends \
    emacs-intl-fonts \
    fonts-arphic-bkai00mp \
    fonts-arphic-bsmi00lp \
    fonts-arphic-gbsn00lp \
    fonts-arphic-gkai00mp \
    fonts-arphic-ukai \
    fonts-arphic-uming \
    fonts-dejavu \
    fonts-dejavu-core \
    fonts-dejavu-extra \
    fonts-droid-fallback \
    fonts-firacode \
    fonts-guru \
    fonts-guru-extra \
    fonts-liberation \
    fonts-opensymbol \
    fonts-roboto \
    fonts-roboto-hinted \
    fonts-stix \
    fonts-symbola \
    fonts-texgyre \
    fonts-unfonts-core && \
    # update font cache
    echo "Update font cache." &&\
    update-ca-certificates &&\
    fc-cache -fv

RUN install2.r --deps=TRUE remotes \
    && install2.r --deps=TRUE tinytex \
    && install2.r --deps=TRUE formatR \
    && install2.r --deps=TRUE rmarkdown
RUN installGithub.r kindlyops/tufte \
    && installGithub.r --deps=TRUE kindlyops/ggradar \
    && install2.r --deps=TRUE tint \
    && install2.r --deps=TRUE gridExtra \
    && install2.r --deps=TRUE ggthemes \
    && install2.r --deps=TRUE reshape2 \
    && install2.r --deps=TRUE cowplot \
    && install2.r --deps=TRUE likert \
    && installGithub.r --deps=TRUE haozhu233/kableExtra
# versioned rocker images have repo set to MRAN snapshots for reproducibility
#&& install2.r --deps=TRUE kableExtra
#RUN apt-get install -y texlive-xetex
#RUN apt-get install -y texlive-fonts-recommended texlive-fonts-extra ghostscript
# RUN mkdir /usr/local/context && \
#     cd /usr/local/context && \
#     wget http://minimals.contextgarden.net/setup/first-setup.sh && \
#     chmod +x first-setup.sh && \
#     sh first-setup.sh
# ENV OSFONTDIR=/usr/share/fonts
# ENV TEXROOT=/usr/local/context/tex
# ENV PATH=/usr/local/context/tex/texmf-linux-64/bin:/usr/local/context/bin:$PATH
#RUN fc-cache -fv /usr/share/fonts/

# lets do the super insecure thing 
# https://tex.stackexchange.com/questions/528634/tlmgr-unexpected-return-value-from-verify-checksum-5
#RUNtlmgr init-usertree
#RUN tlmgr option repository http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2019/tlnet-final
#RUN tlmgr install roboto fetamont --verify-repo=none || true
ADD install-source-pro.sh /install-source-pro.sh
RUN /install-source-pro.sh