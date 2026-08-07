# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.3 / @SHA_*@ placeholders below with
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
  version "0.7.3"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.3/stella-0.7.3-aarch64-apple-darwin.tar.gz"
      sha256 "fee388f3b343b1d26b02422bffbc1332cdaa4b4d3705a198372453f3c9429d28"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.3/stella-0.7.3-x86_64-apple-darwin.tar.gz"
      sha256 "7c772381d1c7c8f2aafa2d8c54c304d050842bb46dec411f7fe395350b698f1d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.3/stella-0.7.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "642228015ef4c822d6ab1a9e5fbf6bdec3458662a608bb2df807101efabad572"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.3/stella-0.7.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "76fe31c11e45a765dfa2c8d1e2ae693ec1fd4359c731d39e50962e28b4fda14a"
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
