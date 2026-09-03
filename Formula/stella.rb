# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.319 / @SHA_*@ placeholders below with
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
  version "0.9.319"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.319/stella-0.9.319-aarch64-apple-darwin.tar.gz"
      sha256 "ef6267b5e7fe388c7ae77b80fe378335feda90e95c6082879378c55ff79096bc"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.319/stella-0.9.319-x86_64-apple-darwin.tar.gz"
      sha256 "ae7bdaef72377493fd6e868842d757ce12f9326bda706bbffd2701fdc1d29016"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.319/stella-0.9.319-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "180dfc6c1882a594d3143ba5aa2010fab5b6cb2bcc2c68ad4a399723b3520ac1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.319/stella-0.9.319-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eef60f18d18115e999d0ebe5f5faf3c6e391ddb400720da575295795fc0346e4"
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
