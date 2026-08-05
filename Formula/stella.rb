# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.116 / @SHA_*@ placeholders below with
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
  version "0.6.116"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.116/stella-0.6.116-aarch64-apple-darwin.tar.gz"
      sha256 "0ebc22886bc8d89fe31a56da3a676fc638b4ba631dec79b69aa301b951a303b7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.116/stella-0.6.116-x86_64-apple-darwin.tar.gz"
      sha256 "17590fc86815a7cd4bfe538ccaa767956da924930fffc49e24fef30d852e408b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.116/stella-0.6.116-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "034b09c819e40eb6b8c8b099cb6ac28e72b94763ed9a4c3bfe3c9f4eabcb79cd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.116/stella-0.6.116-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "73a832596022baedb557c54c4fe330f11c34348055a8696beaa752df1388ecef"
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
