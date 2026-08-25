# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.207 / @SHA_*@ placeholders below with
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
  version "0.9.207"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.207/stella-0.9.207-aarch64-apple-darwin.tar.gz"
      sha256 "7ab2bed4d2981b9fab587eb0e8ab8d6731e7114a6531d7c81338d095329dd412"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.207/stella-0.9.207-x86_64-apple-darwin.tar.gz"
      sha256 "48619520ed604d8c1ab3f7c7554997c9bf8ce769b1e7dc45fe5d9d0286bc8739"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.207/stella-0.9.207-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3d45458abab508f13a8fa398edeba9f0c177eb17a8c0bca50ec17a7e72fefff0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.207/stella-0.9.207-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eeecdb5c94dec32af43a88e43893085ed9945323c941c8313c3cf6b0a1e50625"
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
