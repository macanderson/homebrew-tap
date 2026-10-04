# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.482 / @SHA_*@ placeholders below with
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
  version "0.9.482"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.482/stella-0.9.482-aarch64-apple-darwin.tar.gz"
      sha256 "ca828e0af63b53c0ed60c3172d42c00c495e9eab1e4f30645a09eeb5b4a51284"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.482/stella-0.9.482-x86_64-apple-darwin.tar.gz"
      sha256 "1a3f3a32c2e74fbc33f8380fa50a4426ed225af6c1b7314bba6cbe91240d95ef"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.482/stella-0.9.482-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1652a6515ed8a5eb9f420e237e79818889e2df6da9fe9990f2d1425573f07f91"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.482/stella-0.9.482-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6c9e75de36eb44a5f74d66dd9de93f15de42121d57db9523edc3507064c11678"
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
