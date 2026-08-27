# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.251 / @SHA_*@ placeholders below with
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
  version "0.9.251"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.251/stella-0.9.251-aarch64-apple-darwin.tar.gz"
      sha256 "3517920c767f0a0c7774689cda0336211e4989ef66d1c8486c287aa5309f6210"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.251/stella-0.9.251-x86_64-apple-darwin.tar.gz"
      sha256 "37bd887a427e6940221fe21707b4c46991882a9538e1e0a166235ffc981f42db"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.251/stella-0.9.251-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "af03dc169f36f72fdf30377792e40a1ca76a2886bc25b6d33e9b0734a7e4611d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.251/stella-0.9.251-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b219d526bfc2c68985a905adb7c955ff5229570d357d345de92d01ed073fa09d"
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
