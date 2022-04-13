---
title: "Regularly bundling Homebrew formulae to file on macOS with launchctl"
date: 2022-04-13T04:23:29Z
draft: false
tags: ["homebrew", "macos", "launchctl"]
showLicense: false
---

[Homebrew](https://brew.sh) is used by developers everywhere to install software packages not included with the macOS operating system. Developers may save a list of the installed packages on their system to a "Brewfile" with a simple `brew bundle dump` command. However, there's no feature built-in to Homebrew that allows you to create Brewfiles regularly, and automatically.

<!--more-->

I recently broke the screen on my laptop, and had to send it in to Apple to get it replaced. While I waited for my repaired laptop, my company gave me an old Mac laptop, so I could continue to work. When I signed on to it, I experienced the frustration of having all my software packages missing. If only I had backed up a list of my formulae along with the rest of my system!

After this experience, I scoured the internet for methods of backing up all of my Homebrew formulae to file, so that I could quickly restore from it in the event that I lose my laptop again. In this search, I learned about the `brew bundle dump` command, which would do for my Homebrew formulae what `pip freeze` does for Python environments. However, there was no obvious way to have this Brewfile generated regularly and saved to a location that would get backed up into the cloud.

By wrapping the `brew bundle dump` command into a script, and calling that script from `launchctl`, I was able to set up regular backups of my Homewbrew formulae to the cloud.

## Prerequisites

To make this work, you'll need the following:

- A computer running macOS,
- Homebrew, and
- A backup location

For the backup location, I'm using my company's cloud, which for this example I'll say is uploading from `~/.config/brew/backups`.

## Bundling your brews

First, run `brew list` to ensure that you have some formulae to save. These are the packages that we want to be present on our new machine.

```bash
$ brew list
==> Formulae
binutils  gh  gmp  go  hugo ...
```

Now, try saving a manifest of those packages to file with `brew bundle dump`:

```bash
$ brew bundle dump
```

If it worked, the command should have completed quietly. However, you'll see a new `Brewfile` in your working directory:

```bash
$ cat Brewfile 
tap "aws/tap"
tap "homebrew/bundle"
tap "homebrew/core"
brew "gh"
brew "hugo"
brew "jq"
brew "aws/tap/lightsailctl"
```

We could take that file onto a new Mac and have it install all of our packages. For the purposes of this post, though, we'll just uninstall all of the packages on our workstation and re-install them using the Brewfile (thanks to [this StackOverflow answer for an easy way to do this!](https://apple.stackexchange.com/a/339096):

```bash
$ brew remove --force $(brew list --formula)
Uninstalling ...
$ brew remove --cask --force $(brew list)
Uninstalling ...
```

Let's check and make sure that there's no packages installed anymore:

```bash
$ brew list
==> Formulae
```

Now, we can re-install all of our packages with `brew bundle install`:

```bash
$ brew bundle install
Using aws/tap
...
$ brew list
==> Formulae
binutils  gh  gmp  go  hugo ...
```

It's important to note that if the package has been removed from the index, or is otherwise unavailable, *you will not be able to install it again, here*. The `brew bundle dump` command does not save the actual packages, but the references to them.

Let's move on to wrapping some of this behavior in a script.

## Creating Brewfiles programmatically

The next step is to create a script that our `launchctl` process will be able to run regularly. We need it to do the following things:

Given a directory, do:
1. Create the directory if it doesn't exist
2. Remove all but the `x` most recent Brewfiles
3. Create a new Brewfile

The following script achieves this:

```bash
#!/usr/bin/env zsh
#

# for debugging
set -x

if [ "$#" -ne 1 ]
then
    echo "Usage:"
    echo "  ./homebrew_backup.sh <backup folder>"
    exit 1
fi

PREFIX=${1}
mkdir -p ${PREFIX}

NUM_TO_KEEP=50
# Remove all but the ${NUM_TO_KEEP} newest Brewfiles in the backup area
# https://stackoverflow.com/a/34862475
(cd ${PREFIX} && ls -tp | grep -v '/$' | tail -n +${NUM_TO_KEEP} | xargs -I {} rm -- {})

# Create the manifest, and move it into the backup location, timestamped with the current time
brew bundle dump
mv Brewfile ${PREFIX}/Brewfile.$(date +%s)

exit 0
```

Put the above into a script named `homebrew_backup.sh`, save it, and `chmod +x` it so that it can be executed by `launchctl`.

For the rest of this post, I'll assume you've saved the script to `${SCRIPT_LOCATION}/homebrew_backup.sh`. We can test the script manually:

```bash
$ ${SCRIPT_LOCATION}/homebrew_backup.sh ~/.config/brew/backups
```

A new `Brewfile` should be created in `~/.config/brew/backups`.

## A Homebrew gotcha

If we tried to run this with `launchctl` now, we'd get an error when it gets to the `brew bundle dump` stage, complaining about `brew` not being found. If we put the absolute path to the `brew` binary in the script, it will get us a little further, but it will still fail.

We need to make sure that the `launchctl` environment knows where the `brew` binary is. To do so, run the following:

```bash
$ launchctl setenv PATH ${PATH}
```

This will set the `${PATH}` environment variable that `launchctl` uses to whatever it is in your shell.

You can make sure that it was set properly by running:

```bash
$ launchctl getenv PATH
```

If the `${PATH}` looks good, we'll move on to actually automating this thing.

## Automating this thing

With `${SCRIPT_LOCATION}/homebrew_backup.sh` working, we're ready to create a `launchctl` configuration to run it at a regular interval.

Create a new file called `com.johndoe.homebrewbackup.plist`. This will tell macOS how we want this script to be run.

We want the `${SCRIPT_LOCATION}/homebrew_backup.sh` script to be run every 3 hours (10800 seconds), with `~/.config/brew/backups` as the backup directory, and `/tmp/com.johndoe.homebrewbackup.plist/homebrewbackup.out` and `/tmp/com.johndoe.homebrewbackup.plist/homebrewbackup.err` as the job's `stdout` and `stderr` log files, resepectively.

Put the following into your `plist`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>com.johndoe.homebrewbackup.plist</string>
    
    <key>WorkingDirectory</key>
    <string>/tmp/com.johndoe.homebrewbackup.plist</string>
    
    <key>ProgramArguments</key>
    <array>
      <string>${SCRIPT_LOCATION}/homebrew_backup.sh</string>
      <string>~/.config/brew/backups</string>
    </array>
    
    <key>Nice</key>
    <integer>1</integer>
    
    <key>StartInterval</key>
    <!-- every 3 hours -->
    <integer>10800</integer>
    
    <key>RunAtLoad</key>
    <true />
    
    <key>StandardErrorPath</key>
    <string>/tmp/com.johndoe.homebrewbackup.plist/homebrewbackup.err</string>
    
    <key>StandardOutPath</key>
    <string>/tmp/com.johndoe.homebrewbackup.plist/homebrewbackup.out</string>
  </dict>
</plist>
```

Once this file is saved, load it into `launchctl` with the following:

```bash
$ launchctl load ${SCRIPT_LOCATION}/com.johndoe.homebrewbackup.plist
```

After some time, you should see log messages going to the above `stdoud` and `stderr` files, and new Brewfiles being created in your `~/.config/brew/backups` folder.

If your cloud backup service only looks at a certain location on your Mac, make sure that you update the above to use that location instead of `~/.config/brew/backups`.

## Next steps

Give it a go! Next time you find yourself without all your Homebrew formulae, hopefully this will save you some frustration.