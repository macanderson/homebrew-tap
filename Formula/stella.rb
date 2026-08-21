# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.120 / @SHA_*@ placeholders below with
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
  version "0.9.120"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.120/stella-0.9.120-aarch64-apple-darwin.tar.gz"
      sha256 "3d44d001b99642fbb599c3d06e62512d13b106908e30abb895986d48613fc09a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.120/stella-0.9.120-x86_64-apple-darwin.tar.gz"
      sha256 "6876ee9c95c974e16c2952c56f3e40847a65c82909f6538ff86ecff6ada8f8cf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.120/stella-0.9.120-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "44046a74f3521dd29f78e9e2b4ce38a1c65db2ddbe90ff68c7d6183d6afd2cdc"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.120/stella-0.9.120-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "621546c9ce657f75300ba45dd1cb5aad53995d4bc7df8765605bbac63003b899"
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
