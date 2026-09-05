# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.332 / @SHA_*@ placeholders below with
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
  version "0.9.332"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.332/stella-0.9.332-aarch64-apple-darwin.tar.gz"
      sha256 "fa508882afb76ffb2b45aca0515f0514e82346691eda14ce7c96821dda288fac"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.332/stella-0.9.332-x86_64-apple-darwin.tar.gz"
      sha256 "b20be4f2ddf55185fd79f00b9b456f48cf20005090bb93995ebf7fe4dda502c2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.332/stella-0.9.332-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4dd9270d2fa8b702bed49e077c0573d5d784f283a901bb34167e60e374f2654a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.332/stella-0.9.332-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "32c21667a68f898a192431e57d8b8713ffa0a34be36506e01a6e6828f7d7112d"
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
