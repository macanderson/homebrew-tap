# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.32 / @SHA_*@ placeholders below with
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
  version "0.9.32"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.32/stella-0.9.32-aarch64-apple-darwin.tar.gz"
      sha256 "ed51ccc791164376616df52f9eccbcbcecb73afe871d441baf06f971b7fe43e6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.32/stella-0.9.32-x86_64-apple-darwin.tar.gz"
      sha256 "d7aea4297ddf3982a9d728a2383405d07e2f1b4141acd300c5ce325cacdbbe6d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.32/stella-0.9.32-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "886e8fa811fd38349f2371eab90c78ed579cb97b230b5e74cd094d8cffc264a6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.32/stella-0.9.32-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b7ebf0b0ef392ad59a80b97117774bd53eb8322f0da2d89e9732bf945d88a60a"
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
