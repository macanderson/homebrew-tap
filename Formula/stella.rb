# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.33 / @SHA_*@ placeholders below with
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
  version "0.9.33"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.33/stella-0.9.33-aarch64-apple-darwin.tar.gz"
      sha256 "a9816495ef8dc9191994c54cb2a9dabb213eae2a2184dd7470949dc1ad772d08"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.33/stella-0.9.33-x86_64-apple-darwin.tar.gz"
      sha256 "ec125fa9aab9eff46382603c3663053e6b2ada48cf12b261160c28cb23364b9d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.33/stella-0.9.33-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ee496468d6af157fc0217ccb278a8b07a5a9c60dd815ed641c07d1f839d8fc18"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.33/stella-0.9.33-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "af56426be36a08fa51c42899e99c3bec8f8dfca6bdc66b70e1b150f76c8ee75a"
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
