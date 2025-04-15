# docker
docker environment for C++ development including 
- python
- premake5

## build image
call _dockerBuild.cmd_

## run container
call _dockerRun.cmd_

### mounts
**/git folder**

The folder you cloned this repo into will be mounted to _/git_ folder in container.
So this repo will be _/git/docker_.

**home folder**

The local _dev_ folder will be mounted as user _dev_ ´s home folder.

Advantage:
-   the bash history will be kept locally

**github access**

If you want to access gitHub (push / pull) copy your personal _.ssh_ folder into _dev_ folder.

**your aliases**

For personal aliases create _.local_aliases_ in _dev_ folder.

## local tree
```
docker
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
