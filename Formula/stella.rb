# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.66 / @SHA_*@ placeholders below with
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
  version "0.6.66"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.66/stella-0.6.66-aarch64-apple-darwin.tar.gz"
      sha256 "f61dae3f63730af34e8bc1ae1df40b25d3a05de73b5a66738070c010fe886c39"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.66/stella-0.6.66-x86_64-apple-darwin.tar.gz"
      sha256 "c0966d35d0cc9583a445805def2b8589cb8d81b5ea31094ff78712a4b3e68eaa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.66/stella-0.6.66-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "17e54fe98ab524199aa365f8782dbc9e639421854fa830374457071ffe4063a6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.66/stella-0.6.66-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cdc1415515134c7ed1ab6ab61bc910b6b3cda9604a44f1fab0068dcc6a8121a9"
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
