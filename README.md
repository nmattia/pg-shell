# pg-shell: PostgreSQL in a shell

The `pg-shell` environment allows you to run PostgreSQL instances with _no
strings attached_. The associated processes and data disappear when you exit
your shell.

<img src="pgshell.png" alt="pg-shell" style="width: 400px;"/>

# Usage

_The examples assume that the [`pg-shell`](./pg-shell) script was loaded. For
installation instructions, see the [Install](#install) section below._

By loading the [`pg-shell`](./pg-shell) script you import three functions into
your environment: `start_pg`, `list_pg` and `stop_pg`. You can use those to
respectively start a new PostgreSQL instance, list the currently running
(`pg-shell`) PostgreSQL instances and stop a particular PostgreSQL instance.

Starting a local PostgreSQL instance is very easy:

``` shell
$ start_pg
Creating /home/nicolas/projects/nmattia/pg-shell/.pg/gentle-british-time directory
Starting postgres...
...
Now starting postgres...
Postgres started
Logs are written to /home/nicolas/projects/nmattia/pg-shell/.pg/gentle-british-time/pglog.

   name:  gentle-british-time
   pid:   24901
   port:  5432
```

The `start_pg` function will start a PostgreSQL instance running in the
background. By default the instance is started on port `5432` and the data is
located in `<ROOT>/.pg/<NAME>`, where `ROOT` is the directory from which you
_evaluated_ the [`pg-shell`](./pg-shell) script and `NAME` is a randomly
generated name. In the example above, the `ROOT` is
`/home/nicolas/projects/nmattia/pg-shell/` and the randomly generated name
`NAME` is `gentle-british-time`. You can stop the instance by exiting the
shell:

``` shell
$ exit
stopping gentle-british-time
killing 24901
removing /home/nicolas/projects/nmattia/pg-shell/.pg/gentle-british-time
```

When calling `start_pg` you may specify the name and port of the PostgreSQL
instance (note that the "name" of the instance is a `pg-shell` concept and has
nothing to do with database names). Specifying the port is necessary if you
need several instances running at the same time:

``` shell
$ start_pg
Creating /home/nicolas/projects/nmattia/pg-shell/.pg/brave-italian-way directory
Starting postgres...
...
Now starting postgres...
Postgres started
Logs are written to /home/nicolas/projects/nmattia/pg-shell/.pg/brave-italian-way/pglog.

   name:  brave-italian-way
   pid:   25743
   port:  5432

$ start_pg --name some-name --port 5555
name read from input: some-name
port read from input: 5555
Creating /home/nicolas/projects/nmattia/pg-shell/.pg/some-name directory
Starting postgres...
...
Now starting postgres...
Postgres started
Logs are written to /home/nicolas/projects/nmattia/pg-shell/.pg/some-name/pglog.

   name:  some-name
   pid:   25768
   port:  5555
```

You can list the names of your running instances:

``` shell
$ list_pg
brave-italian-way
some-name
```

All instances will be destroyed upon shell exit:

``` shell
$ exit
stopping some-name
killing 25768
removing /home/nicolas/projects/nmattia/pg-shell/.pg/some-name
stopping brave-italian-way
killing 25743
removing /home/nicolas/projects/nmattia/pg-shell/.pg/brave-italian-way
```

## Install

The `pg-shell` script needs access to two PostgreSQL executables, namely:

* `initdb` for initializing the databases, and
* `postgres` for starting the databases,

which you can either install from your system's package manager (e.g. `sudo apt
install postgresql`) or through a nix-shell with the following command:

``` shell
$ nix-shell -p postgresql
```

Once PostgreSQL is available, the simplest usage is to source the release:

``` shell
$ eval "$(curl https://nmattia.github.io/pg-shell/v0-0-1)"
```

Alternatively, you can clone the repository (or simply get a copy of
[`pg-shell`](./pg-shell)) and source it:

``` shell
$ . path/to/nmattia-pg-shell/pg-shell
```

Both of the above commands will load `start_pg()`, `list_pg()` and `stop_pg()`
in your environment.

# Release checklist

1. Make sure you're on (the latest) master and that all files have been
   committed.

1. Review the previous releases with `git tag -l`.

1. Decide on the new version: `MAJOR-MINOR-PATCH`.

    > Given a version number MAJOR.MINOR.PATCH, increment the:
    >
    > MAJOR version when you make incompatible API changes,
    > MINOR version when you add functionality in a backwards-compatible
    > manner, and
    > PATCH version when you make backwards-compatible bug fixes.

1. Check out the Github Pages branch:

    ``` shell
    $ git worktree add gh-pages gh-pages
    ```

1. Copy the latest pg-shell to the Github Pages branch:

    ``` shell
    $ cp pg-shell gh-pages/vMAJOR-MINOR-PATCH
    $ git -C gh-pages/ add -A
    $ git -C gh-pages/ commit -m "Release vMAJOR-MINOR-PATCH"
    $ git -C gh-pages/ push
    ```

1. Tag the commit with `git tag vMAJOR-MINOR-PATCH`.
1. Push with `git push --follow-tags`.
