# triton-jupyter-notebook

## Build the docker image

```bash
docker build --build-arg USERNAME=$USER -t triton-jupyter -f Dockerfile .
```

## Run the docker image

```bash
$ docker run  -p 8888:8888 -v /root/mtahhan/triton-jupyter:/notebooks triton-jupyter
[I 2024-11-26 16:57:27.709 ServerApp] jupyter_lsp | extension was successfully linked.
[I 2024-11-26 16:57:27.716 ServerApp] jupyter_server_terminals | extension was successfully linked.
[I 2024-11-26 16:57:27.723 ServerApp] jupyterlab | extension was successfully linked.
[I 2024-11-26 16:57:27.729 ServerApp] notebook | extension was successfully linked.
[I 2024-11-26 16:57:27.731 ServerApp] Writing Jupyter server cookie secret to /opt/app-root/src/.local/share/jupyter/runtime/jupyter_cookie_secret
[I 2024-11-26 16:57:28.119 ServerApp] notebook_shim | extension was successfully linked.
[I 2024-11-26 16:57:28.168 ServerApp] notebook_shim | extension was successfully loaded.
[I 2024-11-26 16:57:28.174 ServerApp] jupyter_lsp | extension was successfully loaded.
[I 2024-11-26 16:57:28.177 ServerApp] jupyter_server_terminals | extension was successfully loaded.
[I 2024-11-26 16:57:28.184 LabApp] JupyterLab extension loaded from /opt/app-root/lib64/python3.12/site-packages/jupyterlab
[I 2024-11-26 16:57:28.185 LabApp] JupyterLab application directory is /opt/app-root/share/jupyter/lab
[I 2024-11-26 16:57:28.187 LabApp] Extension Manager is 'pypi'.
[I 2024-11-26 16:57:28.231 ServerApp] jupyterlab | extension was successfully loaded.
[I 2024-11-26 16:57:28.243 ServerApp] notebook | extension was successfully loaded.
[I 2024-11-26 16:57:28.244 ServerApp] Serving notebooks from local directory: /notebooks
[I 2024-11-26 16:57:28.244 ServerApp] Jupyter Server 2.14.2 is running at:
[I 2024-11-26 16:57:28.244 ServerApp] http://3de8f9b18027:8888/tree?token=74cbac9d4ae95aff21362227b0d94cb96951d3bbf372cc9b
[I 2024-11-26 16:57:28.244 ServerApp]     http://127.0.0.1:8888/tree?token=74cbac9d4ae95aff21362227b0d94cb96951d3bbf372cc9b
[I 2024-11-26 16:57:28.245 ServerApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 2024-11-26 16:57:28.253 ServerApp]

    To access the server, open this file in a browser:
        file:///opt/app-root/src/.local/share/jupyter/runtime/jpserver-1-open.html
    Or copy and paste one of these URLs:
        http://3de8f9b18027:8888/tree?token=74cbac9d4ae95aff21362227b0d94cb96951d3bbf372cc9b
        http://127.0.0.1:8888/tree?token=74cbac9d4ae95aff21362227b0d94cb96951d3bbf372cc9b
[I 2024-11-26 16:57:28.732 ServerApp] Skipped non-installed server(s): bash-language-server, dockerfile-language-server-nodejs, javascript-typescript-langserver, jedi-language-server, julia-language-server, pyright, python-language-server, python-lsp-server, r-languageserver, sql-language-server, texlab, typescript-language-server, unified-language-server, vscode-css-languageserver-bin, vscode-html-languageserver-bin, vscode-json-languageserver-bin, yaml-language-server
```
Navigate to http://127.0.0.1:8888/tree?token=74cbac9d4ae95aff21362227b0d94cb96951d3bbf372cc9b
and the notebooks will be mounted in the container at `/notebooks`.


## Converting python files to Jupyter notebooks

```
pip install p2j
p2j script.py
```