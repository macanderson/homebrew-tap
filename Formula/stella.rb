# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.315 / @SHA_*@ placeholders below with
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
  version "0.9.315"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.315/stella-0.9.315-aarch64-apple-darwin.tar.gz"
      sha256 "69d4f4fa3e843f8c8a8a9e6f877b509ca2e886fc765e7b889be6c5298ac1e03e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.315/stella-0.9.315-x86_64-apple-darwin.tar.gz"
      sha256 "505db07758a6dcf60ba909f31683dfca4d00eb85cbb5b0643f6b32a8b4cb4411"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.315/stella-0.9.315-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8ccb16c6756835a5f7fbd724b5ea0b23e926d54378e3c78d5baee904623ad6b0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.315/stella-0.9.315-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "188da2ea6ae2afe56f87aafe1914d9464fefd40b8295643b62154da117aea9a2"
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
