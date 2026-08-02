# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.69 / @SHA_*@ placeholders below with
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
  version "0.6.69"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.69/stella-0.6.69-aarch64-apple-darwin.tar.gz"
      sha256 "1b64f0236cc1cab095bf8d37cb9ed18efad176b1742c314730b6c8d2d57994b3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.69/stella-0.6.69-x86_64-apple-darwin.tar.gz"
      sha256 "3f0abe5dfb77fdf4f19ca75583bc1609f615f9829f46454aba68f0b0c6c71bc8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.69/stella-0.6.69-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ad39f47104882f5eb8fed62a3c7774e05a63a6b8e391d0d4a765e128f5c67021"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.69/stella-0.6.69-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1f6700f74dd21c0346b29696e1097eefaa27f21347a7f41aeb1ccfeed0c40f9f"
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
