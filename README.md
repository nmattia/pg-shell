# pg-shell: PostgreSQL in a shell

![pgshell](./pgshell.png)


# Release checklist

1. Make sure you're on (the latest) master and that all files have been
   committed.

1. Review the previous releases with `git tag -l`.

1. Decide on the new version: `MAJOR-MINOR-PATCH`.

> Given a version number MAJOR.MINOR.PATCH, increment the:
>
> MAJOR version when you make incompatible API changes,
> MINOR version when you add functionality in a backwards-compatible manner, and
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
