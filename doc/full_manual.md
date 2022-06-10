# Workflow manual

This is the detailed manual for **CDE** users.

## Managing sources

**CDE** root directory contains the following parts:

- Sources for building **CDE** docker containers.
- **CDE** documentation, which you are reading now.

### Getting CDE sources

```shell
$ git clone https://github.com/horrorist1/CDE.git
$ cd CDE
```

This directory will be refered as *CDE_ROOT*.

### Placing developed sources

**CDE** source tree doesn't contain any files or references to external software projects and you
have to get them yourself. Those sources should be placed under `CDE_ROOT/repos` directory using
any method: `git clone`, `svn checkout`, etc.

## Initialize CDE environment

One clone of **CDE** sources allows running only one instance of **CDE** container.
To initialize **CDE** environment, run the following command from *CDE_ROOT* directory:

```shell
[username@hostname ~]$ . init_cde
CDE initialized.
Type 'cmt --help'
[username@CDE-hostname CDE]$
```

This command will change your shell prompt (`PS1`) and add `CDE-` before the original hostname.

Also it will add path to `cmt` in your `CDE_ROOT/tools` directory to your `PATH`.

If you want to save the changes made to your environment, you can run:

To deinitialize **CDE** environment simply run in `CDE_ROOT` directory:

```shell
[username@hostname ~]$ . init_cde --deinit
```

You shell prompt will be restored to the previous default.

Execute `. init_cde -h` to get all options.

## CDE Management Tool

**cmt** is a single tool that is intended for managing **CDE** containers on the workstation.
For the help you can use `cmt -h` at any time.

Also if something goes wrong and **cmt** doesn't work as specified, you can try to get debugging
information running it as `cmt -d`.

```shell
usage: cmt [-h] [-d] {run,delete,list,status} ...

CDE management tool 1.0.0

optional arguments:
  -h, --help            show this help message and exit
  -d, --debug           Debug output

subcommands:
  commands

  {run,delete,list,status}
    run                 Creates new instance of CDE, prints it's NAME and
                        launches console.
    delete              Delete existing instance of CDE selected by NAME.
    list                List all CDE instances.
    status              Print CDE working directory.
```

### Getting CDE working directory

To print the current working `CDE_ROOT` directory:

```shell
[username@CDE-hostname CDE]$ cmt
CDE working directory is '/home/username/CDE'
```

or

```shell
[username@CDE-hostname CDE]$ cmt status
CDE working directory is '/home/username/CDE'
```

### List CDE containers

To list all **CDE** containers run:

```shell
[username@CDE-hostname CDE]$ cmt list
Curr    Names          Image     Created                 Running          Mount point
->      username_2     cde:1     2022-02-01 14:45:54     Up 4 seconds     /home/username/CDE
        username_1     cde:2     2022-04-20 16:07:26     Up 47 hours      /home/username/CDE1
```

The legend:

- `Curr` points to the instance of **CDE** that is currently running in your `CDE_ROOT`.
- `Names` is the name of **CDE** instance, which is your username and running number.
- `Image` is the name of docker image from which **CDE** container was created.
- `Created` is the creation date.
- `Running` is elapsed time since container was started.
- `Mount point` is the `CDE_ROOT` for this **CDE** container.

### Run CDE container

You can run a new instance of **CDE** container, if it doesn't exist in your current `CDE_ROOT`:

```shell
[username@CDE-hostname CDE]$ cmt run
[CDE#username_1 CDE]$
```

The `username_1` is the name of newly created container.

Even if you exit from **CDE** container, it will remain until you explicitly
delete it, and you can re-login to it at any time.

```shell
[CDE#username_1 CDE]$ exit
[username@CDE-hostname CDE]$ cmt run
[CDE#username_1 CDE]$
```

### Delete CDE container

If you don't need **CDE** container any more, you can easily delete it by name:

```shell
[username@CDE-hostname CDE]$ cmt delete username_1
Are you sure you want to delete username_1? [y/N] y
Successfully deleted CDE ' username_1'.
[username@CDE-hostname CDE]$
```

## Working inside CDE container

### Working with docker

`docker` and `docker-compose` commands will be primarily used within the **CDE** container to manage
development containers `dev`. The file `dev.yml` describes the configuration for this `dev` container.

> **Tip**: Developers may opt to alias `docker-compose -f dev.yml` command since it will be
> used multiple times in this workflow.

```shell
[CDE#username_1 CDE]$ alias cde="sudo docker-compose -f dev.yml"
```

### Starting containers

The containers inside **CDE** container are started manually using `docker-compose` command.
`docker-compose -f dev.yml up -d` will create the container, network, mount volumes.

```shell
[CDE#username_1 CDE]$ sudo docker-compose -f dev.yml up -d
Creating network "cde_default" with the default driver
Creating dev ... done
[CDE#username_1 CDE]$
```

### List images

`docker images` lists all tagged images inside **CDE** container.

```shell
[CDE#username_1 CDE]$ sudo docker images
REPOSITORY   TAG                 IMAGE ID            CREATED             SIZE
dev          latest              d5518a614c2b        24 hours ago        964MB
documenter   1                   c75d3b06986a        24 hours ago        516MB
developer    1                   a293cf81ab70        24 hours ago        964MB
builder      1                   fcac462200e9        24 hours ago        747MB
runner       1                   2a1820602f67        24 hours ago        416MB
```

Appending `-a` parameter will list all images including intermediate.

### List containers

`docker ps -a` lists all containers and their status.

```shell
[CDE#username_1 CDE]$ sudo docker ps -a
CONTAINER ID        IMAGE           COMMAND                  CREATED             STATUS              PORTS               NAMES
8591de3f8824        dev             "basic-entrypoint.sh…"   3 hours ago         Up 3 hours                              dev
```

### Delete container

`docker-compose -f dev.yml down` will stop and delete all containers and networks that is
previously created by `up`.

```shell
[CDE#username_1 CDE]$ sudo docker-compose -f dev.yml down
Stopping dev ... done
Removing dev ... done
Removing network cde_default
```

To force remove a running container:

```shell
[CDE#username_1 CDE]$ sudo docker rm -f <container name>
```

`docker-compose -f dev.yml up -d --force-recreate dev` will recreate all services or the
specified services.

```shell
[CDE#username_1 CDE]$ sudo docker-compose -f dev.yml up -d --force-recreate
Recreating dev ... done
```

### Installing software with apk

You can easily install additional packages using `apk` package manager.

```shell
sudo -E apk add <you-favourite-package>
```

## Working in development container

To get `bash` in `dev` container:

```shell
[CDE#username_1 CDE]$ sudo docker-compose -f dev.yml exec dev bash
[username_1@dev work]#
```

Alternatively, you can just execute the commands directly inside the `dev` container:

```shell
[CDE#username_1 CDE]$ sudo docker-compose -f dev.yml exec dev ls
moam
```

Use `exit` to return to the **CDE** container. Using `CTRL+p+q` or `CTRL+d` will return you directly to the
host.

## Working with code

### Modifying code

**CDE** and other software sources may be edited from host workspace, or from inside containers.

You can edit source code by using `vim` or by using **SSHFS** to mount host workspace and
editing through your preferred **IDE**.

#### Using vim

By default `vim` is installed in all **CDE** container as the default source code editor.
Refer to `man vim` for more information how to use it.

#### Using SSHFS Mount on host

You can mount your workspace on your Windows laptop and modify source code directly using your
preferred **IDE**.

## Managing CDE SDK

The **CDE SDK** is usually built and published to the registry by **CDE** support team. But there
might be cases if you want to change your working and development environment for whatever reasons.

**CDE SDK** files are located in `CDE_ROOT/sdk` directory. After editing **CDE SDK** sources you
need to rebuild:

```shell
[CDE#username_1 CDE]$ sudo docker-compose -f sdk/sdk.yml build
```

## Cleanup

**CDE** instances are actually taking disk space which is not infinite. The general guidance is to
keep minimal amount or active **CDE** and remove inactive. Use `cmt delete` command for that.
