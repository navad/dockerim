class Dockerim < Formula
  desc "dockerim - Docker IMproved"
  homepage "https://github.com/navad/dockerim"
  head "https://github.com/navad/dockerim.git"
  version "0.1"

  def install
    bin.install "dockerim"
  end

  def self.run_and_check(command)
    system("which #{ command} > /dev/null 2>&1")
  end

  unless run_and_check("docker")
    fail "docker does not seems to be installed. Please install the docker cli tools before installing dockerim"
  end

  test do
    system "dockerim"
  end
end
