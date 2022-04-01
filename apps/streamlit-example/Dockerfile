FROM bitsofparag/pandas:1.4.1

COPY --chown=mambauser . /usr/local/src/app

WORKDIR /usr/local/src/app

RUN micromamba update -n base --yes --file environment.yml \
    && micromamba env export --explicit > /opt/conda/conda-meta.lock

RUN micromamba clean --all --yes \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.pyc' -delete \
    && find /opt/conda/ -follow -type f -name '*.pyo' -delete \
    && find /opt/conda/ -name '*~' -exec rm -f {} + \
    && find /opt/conda/ -name '__pycache__' -exec rm -fr {} + \
    && find /opt/conda/ -type d -name 'tests' -exec rm -fr {} + \
    && find /opt/conda/ -follow -type f -name '*.js.map' -delete

ENV STREAMLIT_BROWSER_GATHER_USAGE_STATS false

CMD ["streamlit", "run", "main.py"]
