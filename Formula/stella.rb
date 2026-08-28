# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.270 / @SHA_*@ placeholders below with
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
  version "0.9.270"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.270/stella-0.9.270-aarch64-apple-darwin.tar.gz"
      sha256 "4894f84d0d41edbb0f76b2d8396e6dd532c599c3cbfcf52d79b551df6c23d38a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.270/stella-0.9.270-x86_64-apple-darwin.tar.gz"
      sha256 "95e2f379b106cd8d12fbef082852bf9e68d853b829a845987e1c7241a323b91e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.270/stella-0.9.270-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5115c524f2e2ffbc7ec8846526ea2af01f41261c7869dc9de2ee9698938618ec"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.270/stella-0.9.270-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6c4b001b8b6c16ff7c23a400321081656fa5e622c4b9ba14dfc35537d60d5c20"
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
