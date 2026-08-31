# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.299 / @SHA_*@ placeholders below with
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
  version "0.9.299"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.299/stella-0.9.299-aarch64-apple-darwin.tar.gz"
      sha256 "06fb87275b7195d9643794e4ac41c46226da235f95788f529854b0e5fca7b991"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.299/stella-0.9.299-x86_64-apple-darwin.tar.gz"
      sha256 "2ff3722effdf4088ed255affa1f6994a94b944103c94951f0e5a6662a7a9d5c8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.299/stella-0.9.299-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6ab4248ffc6573a921b350a0112337a62c4bd38d7fb8a4de84b2fe2d4884b325"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.299/stella-0.9.299-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b5694b0b6352d0a696f3e6b060551abe564e074472d518e306550b26b9c7f5a6"
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
