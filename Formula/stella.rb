# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.28 / @SHA_*@ placeholders below with
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
  version "0.9.28"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.28/stella-0.9.28-aarch64-apple-darwin.tar.gz"
      sha256 "b8e176d6215d78f6f3c51bfa6417af52c17dfb513848ab81efc18b573be6df6f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.28/stella-0.9.28-x86_64-apple-darwin.tar.gz"
      sha256 "fc370de88ff1b8c91c7123ca3e18b7bf3d7c6e5745730362a3aa8aeedf85baaa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.28/stella-0.9.28-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3c435df7d9cc3a09b92d158ad20d910095f893404522c057c1efb483a6dbd332"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.28/stella-0.9.28-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "123d60dcd4cfff11b5ee6df164caaebac57cee8745b6b85c18fe461ef6e98cd0"
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
