ARG MKDOCS_VERSION

FROM squidfunk/mkdocs-material:${MKDOCS_VERSION}

COPY requirements.txt ./requirements.txt

RUN pip install -r requirements.txt
