# dockerim - Docker  IMproved

`dockerim` is a bash script which wraps the basic `docker` and adds some useful new features to the docker CLI to help you work faster, by introducing a concept of "Current Container" variable (`$CURRENT_CONTAINER_ID`) - the container that was recently used.

## Installation

Install on OSX using Homebrew:

```
brew install https://raw.github.com/navad/dockerim/master/dockerim.rb --HEAD
```

After installation, `dockerim` would be available as a shell command.

For improved experience, Add `dockerim` as an alias to `docker` in your `.bashrc`/`.bash_profile`:

```
alias docker="dockerim"
```

## Usage

`dockerim` adds the following commands:

* `dockerim run ...` Intercepts `docker run` command and updates the current container variable accordingly

* `dockerim set <id|index>` - Sets/Overrides the current container id. This can be either a complete new docker container id.
    - `dockerim set 48646005b86e` would set the current container to be `48646005b86e` 
    - `dockerim set 0` would set the current container id to first container found when running `docker ps`

* `dockerim bash [id]` - Starts an interactive bash session inside the current container or given id

* `dockerim logs` - Shows current container logs

* `dockerim kill` - Kills current container

* `dockerim rm` - Removed current container

* `dockerim killall` - Kills **all** containers

* `dockerim rmall` - Removes **all** containers

* `dockerim current` - Prints the current container id

* `dockerim unset` - Clears the current container id

Any other command will invoke the original `docker` cli, so `dockerim` could be a drop-in replacement of the original. 