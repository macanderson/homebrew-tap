# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.342 / @SHA_*@ placeholders below with
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
  version "0.9.342"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.342/stella-0.9.342-aarch64-apple-darwin.tar.gz"
      sha256 "09b6de6e6d496a4d35d33e9d0922cfe85643eb515d681c6801e96c500553b768"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.342/stella-0.9.342-x86_64-apple-darwin.tar.gz"
      sha256 "d5dcae38276ab9283a87ffcb810410503c2fa92fe4b19b1215a41f77f930f1aa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.342/stella-0.9.342-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "39a4aba18f4c8f7749f1be981f9dce59f6cbd6ea5dbf6014a999e5a3dcf30119"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.342/stella-0.9.342-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3a8b7e3c5e8538254ed98bf9c2ac040bb3d8100adc9b54e464203a104c40e133"
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
