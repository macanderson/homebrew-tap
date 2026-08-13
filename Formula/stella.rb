# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.23 / @SHA_*@ placeholders below with
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
  version "0.9.23"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.23/stella-0.9.23-aarch64-apple-darwin.tar.gz"
      sha256 "799d497c41fa2376a8323392b55d96a90ed825284e8b647823ee6869382769a6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.23/stella-0.9.23-x86_64-apple-darwin.tar.gz"
      sha256 "c82d0978ee90515e1840c8a970dd00223525d1511519127e78c0ef4b26d3d04a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.23/stella-0.9.23-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f76f630c18e20c79a78b4c27553c9b00ee3de610eea10877864c41a715e6448b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.23/stella-0.9.23-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "348e265d77b556cb0edb702b2a8dbc745fe7008de04f542c4a6e52c333c5a946"
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
