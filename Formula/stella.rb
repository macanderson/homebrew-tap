# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.271 / @SHA_*@ placeholders below with
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
  version "0.9.271"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.271/stella-0.9.271-aarch64-apple-darwin.tar.gz"
      sha256 "b1648524d4b0eb4b3f7ae302cc3fcd19c1ef3e7330a1a50e495ff039cd911ce9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.271/stella-0.9.271-x86_64-apple-darwin.tar.gz"
      sha256 "1abaeb09294447cefd8ed752a28f23806883c76f1a3dce17186bb8899c9bd762"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.271/stella-0.9.271-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fb74ed6db8788ad7cf95ad017c9791fee00ff24e158e4d84523cfb770c3d4f3e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.271/stella-0.9.271-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fd8c3c84e9942b508ebf9b02d6b16972d62dab82e281473c858e97addff701da"
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
