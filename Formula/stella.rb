# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.19 / @SHA_*@ placeholders below with
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
  version "0.6.19"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.19/stella-0.6.19-aarch64-apple-darwin.tar.gz"
      sha256 "d6d15d42301b90b37be5cd73bf471953ce5af14d60291869a4f996987b27da19"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.19/stella-0.6.19-x86_64-apple-darwin.tar.gz"
      sha256 "1b5c9a7ed9355790ad1322a858aff3b99b35c87224adf3e0bf2b4171922c553a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.19/stella-0.6.19-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a76f7526ddaf439cc30acbfbab00ff3e4cc0d7b8d13647e78b2d881650b87518"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.19/stella-0.6.19-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "85a04a70795f321715beb2b841463019ebec279083130088fde380d495b3d6cd"
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
