# Quick start

> If you are a first time user or working on a new **LinSEE** machine, make sure to complete
> [environment setup](./environment.md) before proceeding.

## Getting the code

Navigate to your **workspace** and clone **CDE** sources.
You may skip this step if you already have a working **CDE** root.

```shell
$ git clone https://github.com/horrorist1/CDE.git
$ cd CDE
```

The `CDE` directory will be further refered as `CDE_ROOT`.

## Placing developed source

You should place all developed sources in `CDE_ROOT/repos` directory.
You can get them by any means: `git clone`, `svn checkout`, etc.

## Initialize CDE

To initialize **CDE** development, from **CDE** root directory run the following command:

```shell
[username@CDE-hostname CDE]$ . init_cde
CDE initialized.
Type 'cmt --help'
```

>One **CDE** clone supports only one running instance of **CDE** container. To create another
instance you have to create another **CDE** workspace.

## Run CDE container

To create new instance of **CDE** container:

```shell
[username@hostname ~]$ cmt run
[CDE#username CDE]$
```

## Get CDE SDK

```shell
[CDE#username CDE]$ sudo docker-compose -f sdk/sdk.yml build
```

## Run `dev` container

To run development container:

```shell
[CDE#username CDE]$ sudo docker-compose -f dev.yml up -d
```

To get bash in development container:

```shell
[CDE#username CDE]$ sudo docker-compose -f dev.yml exec dev bash
```

Your console will be spawn in `/work`. You repositories are mounted from host to `/work/repos`.

Start your work and happy engineering!
