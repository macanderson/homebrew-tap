# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.40 / @SHA_*@ placeholders below with
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
  version "0.5.40"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.40/stella-0.5.40-aarch64-apple-darwin.tar.gz"
      sha256 "5d0d92b0083500ed04b39337a4af5e77c6fb9b8c8b9a75e3c6f7f6f4d4cc80a0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.40/stella-0.5.40-x86_64-apple-darwin.tar.gz"
      sha256 "9aaccff86e75b2aae5ff1e34aca4315ed61d341579bd425b27a860d3be56943c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.40/stella-0.5.40-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "448d5075c8d241affadd767427c8febc619e14e62e4fd93665b8e313849c940f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.40/stella-0.5.40-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "aa8b3c30535a732eec2244344baf4bbb985f4c675ec1f6a54714f739de04a40b"
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
