# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.428 / @SHA_*@ placeholders below with
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
  version "0.9.428"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.428/stella-0.9.428-aarch64-apple-darwin.tar.gz"
      sha256 "9e74cb2319f2be4cc977dd30a5a37d4200634c5a0cb056d5f7048864b9fa7057"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.428/stella-0.9.428-x86_64-apple-darwin.tar.gz"
      sha256 "5e984d47b42e7a404c4359ab63e59653d25fd20ae1a78cefc9c953635ab99fb0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.428/stella-0.9.428-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "433fe5708f2f9d4859eb1e2a771d2232ce44e0c59454c3847e42c644e21d1205"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.428/stella-0.9.428-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1341da0da5dd754755afdb153db92d182f240a161366ab6e8fe363189d52a8a9"
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
