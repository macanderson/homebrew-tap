# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.192 / @SHA_*@ placeholders below with
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
  version "0.9.192"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.192/stella-0.9.192-aarch64-apple-darwin.tar.gz"
      sha256 "dacd153192b3a7f1962d8d0560db1e0c18dbe3a3ac4b879497fecf06b871f920"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.192/stella-0.9.192-x86_64-apple-darwin.tar.gz"
      sha256 "1f32a549b576fd905a17007ff4c007d3de9692ef92705946361f2899bf6b413f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.192/stella-0.9.192-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7f55f0a092633912a9d0c4350a86d4e6cbf488bc609259687b7e5af383095a3b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.192/stella-0.9.192-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6f4811033a2c167a870b6f29fba3b3a438d0eef778b7aa443e8f071f164a6c51"
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
