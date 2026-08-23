# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.143 / @SHA_*@ placeholders below with
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
  version "0.9.143"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.143/stella-0.9.143-aarch64-apple-darwin.tar.gz"
      sha256 "6c4b528915f445b590cf89dac5d8ba5ace371f47d7a3d137a3638d93d53584a3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.143/stella-0.9.143-x86_64-apple-darwin.tar.gz"
      sha256 "4c6a3b56b543fd606c436cec8eb3faf6e2d6aa1ed2090fef738945af8ac37847"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.143/stella-0.9.143-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bbffafc2d345bc8c9da99df228ed5d592db389fcf80c4c7a769674b617e2e3c5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.143/stella-0.9.143-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bcdbe8ea85a91960a56e8b7df6c1076e49890c28df4ad9a3efa06edd15194628"
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
