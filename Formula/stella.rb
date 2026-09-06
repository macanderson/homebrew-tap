# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.368 / @SHA_*@ placeholders below with
# the real version and per-target SHA-256 sums of the prebuilt tarballs, then
# commits the result to the tap repo (macanderson/homebrew-tap) as
# Formula/stella.rb. See .github/workflows/release.yml (the `homebrew` job).
#
# Unlike packaging/homebrew/stella.rb (which builds from source with cargo),
# this installs the prebuilt binary directly — no Rust toolchain required.
class Stella < Formula
  desc "Fast, BYOK, model-agnostic terminal coding agent"
  homepage "https://github.com/macanderson/stella"
  # Explicit version is kept intentionally: brew's URL version-scan is fragile
  # for filenames containing arch tokens (x86_64/aarch64), so we pin it.
  version "0.9.368"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.368/stella-0.9.368-aarch64-apple-darwin.tar.gz"
      sha256 "e2e1ca381b190f9467107d0339d47d0e7380ef57295cbcd6139723dbe9ea79e6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.368/stella-0.9.368-x86_64-apple-darwin.tar.gz"
      sha256 "a81b0424cc166f8ba7bc35f9ace96de5c27be698471a938ce2049def2a2b0bbb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.368/stella-0.9.368-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "500f3cf3f05d1d05f2e3faeba5ed067fa5b4cd45864e9e30cf2ab87605557e10"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.368/stella-0.9.368-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8ad1f78c25767ef1267d91333b2014af1a8aa5a6349793895b2fc9333b346da6"
    end
  end

  # Each tarball unpacks to a single stella-<version>-<target>/ directory that
  # Homebrew descends into automatically, so the binary is at the CWD root.
  def install
    bin.install "stella"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stella --version")
  end
end
