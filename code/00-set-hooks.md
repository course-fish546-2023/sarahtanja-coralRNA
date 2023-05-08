Set Hooks
================
Sarah Tanja
5/4/23

## Setup git hooks to automatically gitignore large files

In this assignment we’re dealing with large files that will end up in
the ../data and ../output directories. To prevent those large files from
clogging up our ability to ‘git push’, we can use built-in hooks to
automatically ignore files larger than 100 MB (no matter the directory
or file name!). Here are the steps to follow:

- Create a new text file in the `.git/hooks/` directory of your
  repository called `pre-commit`

  > *Select the `More` tab with the gear icon under the RStudio Files
  > navigator bar and select ‘show hidden files’ to see the .git
  > folder*.

- Add the following text to the `.git/hooks/pre-commit` file:

<!-- -->

    #!/bin/sh

    # Maximum file size (in bytes)
    max_file_size=104857600

    # Find all files larger than max_file_size and add them to the .gitignore file
    find . -type f -size +$max_file_size -exec echo "{}" >> .gitignore \;

This code sets the max_file_size variable to 100 MB and then uses the
find command to locate all files in the repository that are larger than
the specified max_file_size. The exec option of the find command appends
the name of each file that matches the criteria to the .gitignore file.

Save the pre-commit file and make it executable by running the following
command in Terminal:

``` bash
pwd
cd ../../
chmod +x .git/hooks/pre-commit
```

With these changes, whenever you run a git commit command, Git will
first execute the pre-commit hook, which will automatically add any
files larger than 100 MB to the .gitignore file. This will prevent Git
from tracking these files in the repository going forward.

> In the event that you accidentally committed a big file (\>100MB), you
> can reset to the last successful git master branch push

<div>

> **Warning**
>
> ⚠️**warning this will overwrite any changes you made after your last
> successful push**⚠️

</div>

> If you still want to continue, you can un-comment the code and follow
> this instruction:
>
> First, update all `origin/<branch>` refs to latest:
>
> ``` bash
> #git fetch --all
> ```
>
> Backup your current branch (e.g. `master`):
>
> ``` bash
> #git branch backup-master
> ```
>
> Jump to the latest commit on `origin/master` :
>
> ``` bash
> #git reset --hard origin/master
> ```

------------------------------------------------------------------------
