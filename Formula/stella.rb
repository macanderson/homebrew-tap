# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.340 / @SHA_*@ placeholders below with
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
  version "0.9.340"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.340/stella-0.9.340-aarch64-apple-darwin.tar.gz"
      sha256 "3f3fea6920e3f2a98100c78dac6f1dfb6cf349dce66aa5df1441782d71daf842"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.340/stella-0.9.340-x86_64-apple-darwin.tar.gz"
      sha256 "56605d18e90afec17e6df914c59fc65026d9964ed3412bb177df558f4f24b007"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.340/stella-0.9.340-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ed16b0645360280a6a8c38a679c49b04b70f690ae1b3e150dee5cbf403ee53b4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.340/stella-0.9.340-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0d3f707579beb7d631b17d4b127406e64ff290b7d13e07f6ecd3fd6e1a707cdf"
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
