# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.333 / @SHA_*@ placeholders below with
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
  version "0.9.333"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.333/stella-0.9.333-aarch64-apple-darwin.tar.gz"
      sha256 "4181979eae75a17286ed6880e0398fbe03e403a0fc25068d6a14b119a0bef405"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.333/stella-0.9.333-x86_64-apple-darwin.tar.gz"
      sha256 "4678253c58a2e47e575411b3b5d566e8712ee58803444d76cc4ef352869a4475"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.333/stella-0.9.333-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a9eb5fbff1ca59be349ab908070e983ac29f64c7e12bc87413b91d9f685df5dd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.333/stella-0.9.333-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e3b898c6101829b13683de8390c583c79db0f38083052233b1ce8cdc60ad3fac"
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
