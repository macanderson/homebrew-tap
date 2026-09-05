# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.349 / @SHA_*@ placeholders below with
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
  version "0.9.349"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.349/stella-0.9.349-aarch64-apple-darwin.tar.gz"
      sha256 "1e604d91e22b6c88d2e360a17215c98573b2e83b7c2ad00ddafefab8e5befae3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.349/stella-0.9.349-x86_64-apple-darwin.tar.gz"
      sha256 "e1dd35ee742e038f3341e3e84443107a9536efb8fd4192ff95f6971aacb5eaf9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.349/stella-0.9.349-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e3ae42785f44ba9ef0592aa426c81bc311d074943c942941e64ab59154f8e7e3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.349/stella-0.9.349-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "24ac43e557f2b5844256b0dbcb84c4ed3eaa166062ec5d7d413bc60863198298"
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
