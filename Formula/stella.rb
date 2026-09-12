# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.421 / @SHA_*@ placeholders below with
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
  version "0.9.421"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.421/stella-0.9.421-aarch64-apple-darwin.tar.gz"
      sha256 "e4e3ee7ebd7b089015478816bb1b0d1d279446e33b8ac0bd6fda5d794710f5ca"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.421/stella-0.9.421-x86_64-apple-darwin.tar.gz"
      sha256 "28fcee4d882437e5e34fabd01fc63bf426ae5de8cbffd4179167eba9f2fad5b2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.421/stella-0.9.421-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bc9b7195e7fe3d4618f3f6660127218f31701db4c686c43ff4f9b30b59e48af2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.421/stella-0.9.421-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a626a9bbfc4ab0e0af1998b911d79292b498211e7dab3e4b1a143c3543eba64a"
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
