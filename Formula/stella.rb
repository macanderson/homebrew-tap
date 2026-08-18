# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.92 / @SHA_*@ placeholders below with
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
  version "0.9.92"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.92/stella-0.9.92-aarch64-apple-darwin.tar.gz"
      sha256 "6705ce1ec067fc4425e070477ee8502019ee293ba72d7d225444c4c143794a3f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.92/stella-0.9.92-x86_64-apple-darwin.tar.gz"
      sha256 "9e11217becaad1e94c139c9f17c4200c189aa06b64fe6d0217d8af3a59476fed"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.92/stella-0.9.92-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f06f2d1fe3e6f98fc4fc16ccaacf696d99a61ae36529d9ff1839e47733d60ae1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.92/stella-0.9.92-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0e49c1186a247cfb3fbf5723bc8cc003555e1981199d54e92761ec9599026fe8"
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
