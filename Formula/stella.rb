# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.158 / @SHA_*@ placeholders below with
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
  version "0.9.158"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.158/stella-0.9.158-aarch64-apple-darwin.tar.gz"
      sha256 "96eb5b7c33c4649912c99d14748ae49a4dc562548344a55806de8385ccba1883"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.158/stella-0.9.158-x86_64-apple-darwin.tar.gz"
      sha256 "ebe979a1102eab5480a2ab3c007d278805afb330e22a3280f9c4d8258e918a7c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.158/stella-0.9.158-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2599437e3bfa2902c323a9791049ad704e2a4b245935c7cfa88c401d897c687a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.158/stella-0.9.158-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8161a77ea6d186d20fe0404ab932047bed843c1e6ba7133d17e2a42679b1a0ac"
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
