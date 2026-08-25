# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.221 / @SHA_*@ placeholders below with
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
  version "0.9.221"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.221/stella-0.9.221-aarch64-apple-darwin.tar.gz"
      sha256 "199643e11da713de818c95e7e4911ff12ef16ba6c1ddc7a2fd684c27bbac95b4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.221/stella-0.9.221-x86_64-apple-darwin.tar.gz"
      sha256 "26f6cfaf2ef02c8b3c5e7de6cf3c2b1255cab0924fd31befc52580f6020f25be"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.221/stella-0.9.221-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7f4e51a0a584a5a123a1c355d225a13043049fa7b1e932fce630af85fc0b296e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.221/stella-0.9.221-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5dbcfe1ef5a244f22e49fa7f402174f24fc90f0c1d6492976abb9116499c16a3"
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
