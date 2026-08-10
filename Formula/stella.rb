# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.19 / @SHA_*@ placeholders below with
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
  version "0.8.19"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.19/stella-0.8.19-aarch64-apple-darwin.tar.gz"
      sha256 "6146efe5be11670d5e3f601827c744765188333a2a4b25965d916332fc9903ae"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.19/stella-0.8.19-x86_64-apple-darwin.tar.gz"
      sha256 "aec8c26f21e87338770608f92f83a767b9db7da18a147e65eb3b90bf8298bf4e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.19/stella-0.8.19-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0510405f8897bb102fd741b242af2e4cd878c2c341f873d2e2299749bd9a55b8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.19/stella-0.8.19-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ace1471124f83e4a95d3362fbaa727705650eeec2917a9c2202de2ff15cf0b56"
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
