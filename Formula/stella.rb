# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.15 / @SHA_*@ placeholders below with
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
  version "0.7.15"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.15/stella-0.7.15-aarch64-apple-darwin.tar.gz"
      sha256 "826bf4e2fb27062769017cff3461278d73b1b47f38d2e447c8609f2990025c93"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.15/stella-0.7.15-x86_64-apple-darwin.tar.gz"
      sha256 "e673d979b4dfea1159d9a0c09e7cdeea9cfe06d4d1264e254248bd72aa790ed1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.15/stella-0.7.15-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5a3ba5cd78628298fcc929d35ea4da69fa44bad5c6b5181109c72e27c0086f25"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.15/stella-0.7.15-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2b5716499d4a61ef542246c37d6375936dc681092a553afc95bad5dfdeced0be"
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
