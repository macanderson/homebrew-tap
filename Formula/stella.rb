# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.125 / @SHA_*@ placeholders below with
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
  version "0.9.125"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.125/stella-0.9.125-aarch64-apple-darwin.tar.gz"
      sha256 "6b70e2bb3844065437c2828cc9d4b2ae6cc77bbf35beb2f1e34e261747c5314d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.125/stella-0.9.125-x86_64-apple-darwin.tar.gz"
      sha256 "c5647ccb43fbf6cb194976b3af76cb7b68c0e9fbecab431c0f3a767bdc03fbf5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.125/stella-0.9.125-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8253a3b2b6e8c2bd929cbd8f39b271949f6dc2ba9c894dc3d83d8ce01b527e8a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.125/stella-0.9.125-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9db30a7e98bd485707800c9f9433cfc9566bec58ed3207445d0f10976dab0461"
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
