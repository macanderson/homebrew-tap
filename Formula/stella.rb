# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.309 / @SHA_*@ placeholders below with
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
  version "0.9.309"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.309/stella-0.9.309-aarch64-apple-darwin.tar.gz"
      sha256 "a035298bd97c94d183bcd598986a8e1382793f6980c74e04396310c95747dce2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.309/stella-0.9.309-x86_64-apple-darwin.tar.gz"
      sha256 "953960bb7e7adb0641a0819e06a83f32942b2bbe107cfdf4f30bbbab647f7eb1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.309/stella-0.9.309-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ee3952f1dc70d0b0b1dcef3caaeeed246e0c34cea033c944fb974e05732053b4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.309/stella-0.9.309-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "269bbe8e3b6462b6d8807eb11d9dc32681820b059fe70ce9cb19338820174544"
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
