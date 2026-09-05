# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.338 / @SHA_*@ placeholders below with
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
  version "0.9.338"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.338/stella-0.9.338-aarch64-apple-darwin.tar.gz"
      sha256 "f57baf8862dc6e8682efa6b30a31cb3f0a78522653805c5a5956f9d60722807d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.338/stella-0.9.338-x86_64-apple-darwin.tar.gz"
      sha256 "519aa81dadb2e27f32839b86f71d57aaa25c53491a87002be3784ecc2f787eac"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.338/stella-0.9.338-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e5e082a1777a9cea894007d0103c3ea1c70fd856b6eaa8057e00b9a42dfd49a7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.338/stella-0.9.338-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eae90d6c60f240c5d18605f5a0810b31cee25ffe4e7171049dafe76a9085206d"
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
