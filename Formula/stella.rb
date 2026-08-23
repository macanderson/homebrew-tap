# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.170 / @SHA_*@ placeholders below with
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
  version "0.9.170"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.170/stella-0.9.170-aarch64-apple-darwin.tar.gz"
      sha256 "8c4c381d1e89a1b2220c0c46dcd7c4a0fc37b976399c04a975a84006133298c4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.170/stella-0.9.170-x86_64-apple-darwin.tar.gz"
      sha256 "03decedf95b1c4d39f81f99205f6b23a84b6280ef5c1cc1265e691256d7e7544"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.170/stella-0.9.170-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "39948859e75c25bb2a99b03cd14562478276e78075b9d8d54baba464ec78a17d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.170/stella-0.9.170-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dacf8de262d8bdb8f3a7626908f68721a9366160e444d847b9492aeeb257303b"
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
