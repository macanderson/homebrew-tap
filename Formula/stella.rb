# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.57 / @SHA_*@ placeholders below with
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
  version "0.9.57"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.57/stella-0.9.57-aarch64-apple-darwin.tar.gz"
      sha256 "31e7f8d73f47bf32c8cc42f55718bdcacf589b0e17711b75252dc43744f76605"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.57/stella-0.9.57-x86_64-apple-darwin.tar.gz"
      sha256 "24810ecd7a0ec69c7ab156ae304459227c8ad5a6d309b4c07a6a908df043c4ae"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.57/stella-0.9.57-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "12a30aa4aa8d7fed108ac70cfa08103189643a7758b275591f0a1b8c054a3961"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.57/stella-0.9.57-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "35efc42f2e7e22aa8c71ff8fc99827731554ba71da35389d3b7f79eff318396b"
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
