# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.274 / @SHA_*@ placeholders below with
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
  version "0.9.274"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.274/stella-0.9.274-aarch64-apple-darwin.tar.gz"
      sha256 "aed2e5f0f0bf0b81385701756754f5a480284959252cdfdc2d2585017402bc94"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.274/stella-0.9.274-x86_64-apple-darwin.tar.gz"
      sha256 "9b347c687598e9f435a76dd5db6125a2e46a570a617b9e736ecafaa929169a48"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.274/stella-0.9.274-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1b4e6914436967edc731e8357999f9778daeaf7f9f04f600a552666d0d71ca1d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.274/stella-0.9.274-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d7c6bbb510392d095cc9d2b18452729379b24e61f95c42fcd6637f49631100e1"
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
