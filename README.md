# docker
my personal docker environment for C++ development including 
- python
- premake5
- Bullseye coverage

## /git folder
The folder you cloned this repo into will be mapped to ``/git`` folder in container.
So this repo will be ``/git/docker``.

## Bullseye license key required**
- write license key into ``bullseye_key.txt`` in this directory
- then call dockerBuild.cmd

## github access
If you want to access gitHub (push / pull) copy your personal ``.ssh`` folder into ``dev`` folder.

## your aliases
For personal aliases create ``.local_aliases`` in ``dev`` folder.

## tree
```
docker
├── bullseye_key.txt
├── dev
│   ├── .bash_aliases
│   ├── .bash_history
│   ├── .bashrc
│   ├── .gitconfig
│   ├── .local_aliases
│   └── .ssh/
├── dockerBuild.cmd
├── Dockerfile
├── dockerRun.cmd
├── .gitattributes
├── .gitignore
├── .gitmodules
├── README.md
├── submodules/
```
