# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.53 / @SHA_*@ placeholders below with
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
  version "0.6.53"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.53/stella-0.6.53-aarch64-apple-darwin.tar.gz"
      sha256 "a500632f7675375ee717b1d6e982f3d3113b2754b383a9d96e926f5d304a8b02"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.53/stella-0.6.53-x86_64-apple-darwin.tar.gz"
      sha256 "3cffb03bdbb5e2532ef83feb7273d5d73268a15e8e0d90337c83783e46fe6cb3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.53/stella-0.6.53-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "42aeb8d4d715e576653a5fcec95acf1e0a9ed53f8d1e7ccd1e885f2cc43e778b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.53/stella-0.6.53-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f31039470365d2f937858198b41acedd217ba7d9075abebe2a8b2f5475275509"
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
