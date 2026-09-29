# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.451 / @SHA_*@ placeholders below with
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
  version "0.9.451"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.451/stella-0.9.451-aarch64-apple-darwin.tar.gz"
      sha256 "2ffcbd778cf54847801b75e314331578e041fb303897adb677146c98daaba7fb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.451/stella-0.9.451-x86_64-apple-darwin.tar.gz"
      sha256 "99226b5cd52e2206ea18f2d48bae610ab2094a471c71640d1a9f6923a96e1b84"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.451/stella-0.9.451-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b079bebaa52d2b86de5f17810ed7f430e36ab63a4c344e5f074dcf77d69dab40"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.451/stella-0.9.451-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0d9516b8b13b4dfc6da696a8b2f7143c24ff15a2e579eeee535c9bf08a31928d"
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
