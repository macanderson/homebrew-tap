# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.39 / @SHA_*@ placeholders below with
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
  version "0.5.39"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.39/stella-0.5.39-aarch64-apple-darwin.tar.gz"
      sha256 "69bcbe96d57a07efb5176c7b94f916a2f4602424d5d031b8c939fc2bdef1ffe2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.39/stella-0.5.39-x86_64-apple-darwin.tar.gz"
      sha256 "07b9e27fb039664da072eef4a44b786ac4182cfd0c79ad21917dea69fa8571a9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.39/stella-0.5.39-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8755a0cf72af866596911d6f9ab10f2751c4669f444e535f60df9e880c98d02e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.39/stella-0.5.39-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0618e10da105d9661ef27162d42c1ad0ab36ba7120a0b0769442a06b7e43e8e2"
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
