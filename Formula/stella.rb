# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.291 / @SHA_*@ placeholders below with
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
  version "0.9.291"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.291/stella-0.9.291-aarch64-apple-darwin.tar.gz"
      sha256 "6fe6d76cf30989b509968e1658148357c14844632a268bfb8f340cbd184fa2d7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.291/stella-0.9.291-x86_64-apple-darwin.tar.gz"
      sha256 "e8e7347d8ddad51776934f8af180b5a377745a7aa58f793c1d12b78d5d945eed"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.291/stella-0.9.291-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d7272667524b54414aa58d0a2092d2e6a723bc75109f9ca99b8960927c25f76d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.291/stella-0.9.291-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c05131e8c687d2315fc2893a3bdb413aaef8fa24e0335a266b3e10cd32e21516"
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
