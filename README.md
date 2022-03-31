# Streamlit App

======================

A collection of data-analytics apps rendered by Streamlit

- Git repo: https://github.com/bitsofparag/streamlit-app

# Features

# Run example app

```
docker run -it --rm \
  -p 8501:8501 bitsofparag/streamlit-example:latest
```

# Run your Streamlit app

1. Create app from example template:
```
cp -r apps/streamlit-example apps/my-streamlit-app
```

2. Then `cd apps/my-streamlit-app` and add your code in `main.py`

3. Test if your app works:

```
cd apps/my-streamlit-app && streamlit run main.py
```

4. Update `VERSION` file with a correct tag value

5. Build the container for your app, like so:

```
cd apps/my-streamlit-app
docker build -t local/my-streamlit-app:$(cat VERSION) .
```

6. Run your streamlit app (like the example app above):

```
docker run -it --rm \
  -p 8501:8501 \
  local/my-streamlit-app:$(cat VERSION)
```

_If you want to mount your local working copy:_

```
docker run -it --rm \
  -v ${PWD}:/usr/local/src/app \
  -p 8501:8501 \
  local/my-streamlit-app:$(cat VERSION)
```

# Contributing Guidelines

Please make a fork of the repo, make changes to your local copy and finally make a pull-request to
this repository.

More more information about forking-based gitflow, please refer to [this article](https://www.atlassian.com/git/tutorials/comparing-workflows/forking-workflow).
