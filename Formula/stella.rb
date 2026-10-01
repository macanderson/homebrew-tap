# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.456 / @SHA_*@ placeholders below with
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
  version "0.9.456"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.456/stella-0.9.456-aarch64-apple-darwin.tar.gz"
      sha256 "430c54c411653aab2beac8acd17a698f28b20463e603e340f1dc74fafc9e0a5b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.456/stella-0.9.456-x86_64-apple-darwin.tar.gz"
      sha256 "4ab0e0847e6b9bf68df794de1ed3a5194f502daa03871fc8959c15e34a13f127"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.456/stella-0.9.456-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c929ab85d3d4a0e2f2307f4bc7fd1329f89e6f5d0a242279e8eefed95e3ac780"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.456/stella-0.9.456-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5cf4064f7c817a7ab1f2d26d9b1939d120ce4c1680f8bccdced08b6503eb9c3c"
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
