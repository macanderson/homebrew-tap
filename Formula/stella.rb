# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.468 / @SHA_*@ placeholders below with
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
  version "0.9.468"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.468/stella-0.9.468-aarch64-apple-darwin.tar.gz"
      sha256 "c9bb7c328b78db747a9fa95c256a99cd00c55fca5bae4401e0fa3d631e47dd8e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.468/stella-0.9.468-x86_64-apple-darwin.tar.gz"
      sha256 "5ccead13049962d6a9a6618d0f8fc3ac1cb6c8b4155f01941a0c7a36e03f9a00"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.468/stella-0.9.468-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dea61eb8daa8ae0370a4a0d49199d4df26d42e7e6634412d4c0f4c48bc3f0ef3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.468/stella-0.9.468-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b0a5d9e7a2f5bab1174abdeb91f7d35154ad290cdd2560e502d9afd5dc90a333"
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
