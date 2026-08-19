# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.107 / @SHA_*@ placeholders below with
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
  version "0.9.107"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.107/stella-0.9.107-aarch64-apple-darwin.tar.gz"
      sha256 "7f62bf46caf2f40c7ac3df90c24f71a2d45b50d62abd9ab8daa9bb1675ef86df"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.107/stella-0.9.107-x86_64-apple-darwin.tar.gz"
      sha256 "fe2335d45b8b391b069ec50c86a5418677336155e98562302c7fc7e4521d78cc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.107/stella-0.9.107-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "164743549237174caa1cdcbc2d78b25d1a7f119296c6b4e006927eaa9931282d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.107/stella-0.9.107-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "351b34f39ed37c8c2d58cb555a1ae59e88d57b11d90e93622d1b177ca5fb96db"
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
