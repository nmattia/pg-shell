# pg-shell: PostgreSQL in a shell

![pgshell](./pgshell.png)

# Usage

_This assumes that the [`pg-shell`](./pg-shell) is loaded in your shell. For
installation instructions, see the [Install](#install) section below._

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
