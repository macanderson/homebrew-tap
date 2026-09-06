# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.357 / @SHA_*@ placeholders below with
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
  version "0.9.357"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.357/stella-0.9.357-aarch64-apple-darwin.tar.gz"
      sha256 "0d86a56b6878432414e6713b14b036f2a9063d2ed16af41c108f10a926ad3dac"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.357/stella-0.9.357-x86_64-apple-darwin.tar.gz"
      sha256 "133c3060127a8697d0f78d775e4c0df461fcf26a162edbf461105c49c7bde0a3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.357/stella-0.9.357-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "08f22466331190cd286d7f7283a77cb68620a0e17b65879cb7bf81f79307baaf"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.357/stella-0.9.357-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d106ce46549e99dad159c5f0a5942f1a6df372986320c431c673dd4b7e478a88"
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
