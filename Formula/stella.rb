# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.23 / @SHA_*@ placeholders below with
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
  version "0.8.23"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.23/stella-0.8.23-aarch64-apple-darwin.tar.gz"
      sha256 "65647ede35002cd7bae674785a7fad13ed4dd0b384a83caabd67468d61eb0532"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.23/stella-0.8.23-x86_64-apple-darwin.tar.gz"
      sha256 "66d0a56f4d9ab6a9aba3263a8a85e521414f35b5e812db9bf0d8b3424b25edfd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.23/stella-0.8.23-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fa33ce20455ebb66e37cdd5584efc2ba60aeed5c1687a03e175e737f57febbc8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.23/stella-0.8.23-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "16565c96ddf5125116717a6a91ca3640cde8c3c02510b1c9a4b0edd4f3084f0e"
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
