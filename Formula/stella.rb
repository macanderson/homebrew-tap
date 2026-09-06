# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.361 / @SHA_*@ placeholders below with
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
  version "0.9.361"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.361/stella-0.9.361-aarch64-apple-darwin.tar.gz"
      sha256 "c183ae855dfe257ff536a598f133ce65fda3b8af9c71b29fe11e9e764e6a12ef"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.361/stella-0.9.361-x86_64-apple-darwin.tar.gz"
      sha256 "d458fd628864ac54a6d0dd3133f65b16bad6b06b0332d9703f91df7cff40b38d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.361/stella-0.9.361-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ee46ec674caec984375f8fad9732d549f5f2910b945613d86bd6a5489a7535cd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.361/stella-0.9.361-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d34b170ff3f9a9f4597fb3bf50970caebe94877c44f951d2b3d23ec0bc724fce"
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
