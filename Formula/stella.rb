# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.128 / @SHA_*@ placeholders below with
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
  version "0.9.128"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.128/stella-0.9.128-aarch64-apple-darwin.tar.gz"
      sha256 "5e6508f56b12e3e73bcd4407d759505fb20b534554fa9eb29894c203103860f3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.128/stella-0.9.128-x86_64-apple-darwin.tar.gz"
      sha256 "21b5e8ce99dd96534fcf9708cd90946ff40f3010d77f2649c125aa5d81bf4954"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.128/stella-0.9.128-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9486bb6c54b371949d2af09c084f2a1ad2cb6dc9d4234ec906ce6b4402cdf54d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.128/stella-0.9.128-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c812c38d94886f17c63e2918516b73fd23d6a78bc8d4f7ef24c4e42d9468a30d"
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
