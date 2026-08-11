# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.46 / @SHA_*@ placeholders below with
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
  version "0.8.46"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.46/stella-0.8.46-aarch64-apple-darwin.tar.gz"
      sha256 "d623546819b80d690644bf758ff213a2251bdbd955aca008534d292e28542b93"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.46/stella-0.8.46-x86_64-apple-darwin.tar.gz"
      sha256 "773c70adb6fb8e01785e5e884fed9f415528d49339470453d6c27d5919e7a1f2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.46/stella-0.8.46-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3f2ca90e38301041e1e661a9e24c04e4a246ba6a73d60ec6cee1d5dc1224f549"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.46/stella-0.8.46-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3d08a2c75cd1e8ba26702ab0b1cfdae2f3c440de5c82438213c520c568cb0734"
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
