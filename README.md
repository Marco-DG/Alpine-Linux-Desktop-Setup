# scripts

##### 01_edge-main-repo.sh

- truncates `/etc/apk/repositories`, and by default sources only the `edge/main` repo.
- updates the system to `edge`.

##### 02_create-user-lock-root.sh

- asks the user to specify a *username* and a *password*: a user with such credentials will be created.
- adds the newly created user to the `wheel` group.
- installs the `doas` package (`sudo` alternative).
- disables the `root` user.
- prompts the user to digit the `exit` command and login again as the newly created user, such user will be able to gain root privileges trough the `doas` command.

##### 03_autologin.sh

- installs the `tcc` C compiler (~1Mb) and the `musl-dev` package (~10Mb) which containts the standard C libraries.
- compiles a binary called `autologin` and puts it into `/usr/sbin`, such binary is a wrapper around the `login` binary situated in `/bin`.
- edits `/etc/inittab` adding the `-n -l /usr/sbin/autologin` flags to `/sbin/getty` for each tty.
- truncates `etc/motd`: the file containing the message prompted right after login.
