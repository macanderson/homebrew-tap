# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.110 / @SHA_*@ placeholders below with
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
  version "0.6.110"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.110/stella-0.6.110-aarch64-apple-darwin.tar.gz"
      sha256 "839abea989e1c0ea30f4dcc2d766b60ec18af0c0518684dd872db27c95eb8e96"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.110/stella-0.6.110-x86_64-apple-darwin.tar.gz"
      sha256 "2c500c22578d458c127b7d413fa3087b8cf754c309a596b2aad521c091ef54cf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.110/stella-0.6.110-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4868d3fb913b11ced7992ba4cecb9a012a765f773a790a58a4e3ae649ac3cdc7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.110/stella-0.6.110-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c030dd111ce7bd1cade909956f968816d9b97d3a1d138662149187f4dcbe759a"
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
