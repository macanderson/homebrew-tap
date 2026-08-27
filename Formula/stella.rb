# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.259 / @SHA_*@ placeholders below with
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
  version "0.9.259"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.259/stella-0.9.259-aarch64-apple-darwin.tar.gz"
      sha256 "a54327d7700563d5e6ab0ac93eaeab637215a1ddc0060dacbafae8ee1e787c38"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.259/stella-0.9.259-x86_64-apple-darwin.tar.gz"
      sha256 "fd0003410c22fe770dfc04ceef29cdbef38fb82f4783a951ce79e86ab16b48b2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.259/stella-0.9.259-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5c0634324a214954346927f8181dc16d1eac6f9cc02cb842cf508ab6a03c05fa"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.259/stella-0.9.259-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6a0fef31caeac96739f1fc125e55ad97fb21e4f50c39ba7faa03b39516b76284"
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
