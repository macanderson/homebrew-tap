# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.163 / @SHA_*@ placeholders below with
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
  version "0.9.163"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.163/stella-0.9.163-aarch64-apple-darwin.tar.gz"
      sha256 "0c85f01a06d2a45e01901b5c25b705f40b2ccb538c8ade4d7404d020d9025922"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.163/stella-0.9.163-x86_64-apple-darwin.tar.gz"
      sha256 "4901c9f5780acafdf4f8235ef33efa056e7d0529b7ee5d30f8641f7f9656cac2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.163/stella-0.9.163-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0fefa14a18576c24e40aaf2bc8d5e6507674954e18915456af58869da9f997c2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.163/stella-0.9.163-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "81386f6623fb74b98f18c6a077499b39b31dfebae37f7c874d353a1a9719eab9"
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
