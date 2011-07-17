# kratob does holman does dotfiles

## dotfiles

My dotfiles, forked from the excellent [Holman's dotfiles](http://github.com/holman/dotfiles)

## install

- `git clone git://github.com/kratob/dotfiles ~/.dotfiles`
- `cd ~/.dotfiles`
- `rake install`

The install rake task will symlink the appropriate files in `.dotfiles` to your
home directory. Everything is configured and tweaked within `~/.dotfiles`,
though.

It works a bit different to Holman's version:
- You need to include the dots (so it's `.zshrc.symlink`)
- If you put things in subdirectories, the directory structure (below the topmost) is kept. So the `awesome/.config/awesome.symlink` gets symlinked to `~/.config/awesome`, but `~/.config` itself is left alone.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

## topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `rake install`.

## thanks

I forked [Zach Holman's](http://github.com/holman) excellent [dotfiles](http://github.com/holman/dotfiles), who in turn forked [Ryan Bates](http://github.com/ryanb)' excellent [dotfiles](http://github.com/ryanb/dotfiles).
