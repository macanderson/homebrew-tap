# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.126 / @SHA_*@ placeholders below with
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
  version "0.6.126"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.126/stella-0.6.126-aarch64-apple-darwin.tar.gz"
      sha256 "aa271f4478e44d408b7375ffa1671eca899774e44cf387a0ffaf0adb139d21f2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.126/stella-0.6.126-x86_64-apple-darwin.tar.gz"
      sha256 "f5e4874b9ef4dded8d695bd468e09fd55bccd63a5ff7808e8646b0f5b74700c0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.126/stella-0.6.126-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fdc3f9313960f45a130395d087dd289c8fd284ef86f2cc87eed9e9d4d6e6da29"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.126/stella-0.6.126-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1c5f945cb9e663f2e018d034d217a469d869dd234e7193686ab02af82be3f202"
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
